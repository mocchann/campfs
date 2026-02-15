require 'rails_helper'

RSpec.describe "Fields", type: :request do
  let(:field) { create(:field) }

  describe "GET fields#search" do
    context "検索結果ページが正しく表示されること" do
      before do
        get search_fields_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('検索結果 △ TO_CAMP')
      end
    end

    context "検索パラメータを渡したとき" do
      let!(:matched_field) { create(:field, name: "ターゲットキャンプ場") }
      let!(:unmatched_field) { create(:field, name: "別のキャンプ場") }

      before do
        get search_fields_path, params: { q: { name_cont: "ターゲット" } }
      end

      it "検索結果に一致したキャンプ場が表示されること" do
        expect(response.body).to include(matched_field.name)
      end

      it "検索結果に不一致のキャンプ場は表示されないこと" do
        expect(response.body).not_to include(unmatched_field.name)
      end
    end

    context "ページネーションの2ページ目を開いたとき" do
      before do
        10.times do |i|
          create(:field, name: "ページネーションテスト#{i}")
        end
        get search_fields_path, params: { q: { name_cont: "ページネーションテスト" }, page: 2 }
      end

      it "2ページ目でも200 OKとなること" do
        expect(response.status).to eq(200)
      end

      it "検索件数が表示されること" do
        expect(response.body).to include("検索結果：10件")
      end
    end

    context "並び替えパラメータを指定したとき" do
      let!(:low_field) { create(:field, name: "標高が低いキャンプ場", elevation: "100") }
      let!(:high_field) { create(:field, name: "標高が高いキャンプ場", elevation: "900") }

      it "標高昇順で並ぶこと" do
        get search_fields_path, params: { q: { name_cont: "標高", s: "elevation asc" } }

        low_index = response.body.index(low_field.name)
        high_index = response.body.index(high_field.name)

        expect(low_index).to be < high_index
      end

      it "標高降順で並ぶこと" do
        get search_fields_path, params: { q: { name_cont: "標高", s: "elevation desc" } }

        low_index = response.body.index(low_field.name)
        high_index = response.body.index(high_field.name)

        expect(high_index).to be < low_index
      end
    end
  end

  describe "GET fields#show" do
    context "キャンプ場詳細ページが正しく表示されること" do
      before do
        get field_path(field)
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include(field.name + ' △ TO_CAMP')
      end
    end

    context "口コミが複数ページあるとき" do
      let(:user) { create(:user) }

      before do
        4.times do |i|
          create(:review, field: field, user: user, title: "口コミタイトル#{i + 1}")
        end
        get field_path(field), params: { page: 2 }
      end

      it "2ページ目でも200 OKとなること" do
        expect(response.status).to eq(200)
      end

      it "2ページ目の口コミが表示されること" do
        expect(response.body).to include("口コミタイトル4")
      end
    end

    context "複数口コミ表示時のN+1回避" do
      it "users取得クエリが1回に収まること" do
        3.times do |i|
          review_user = create(:user, email: "nplus1_user_#{i}@example.com")
          create(:review, field: field, user: review_user, title: "nplus1_#{i}")
        end

        sqls = []
        callback = lambda do |_name, _start, _finish, _id, payload|
          sql = payload[:sql]
          next if payload[:name] == "SCHEMA"
          next if sql.include?("sqlite_master") || sql.include?("SHOW FULL FIELDS")

          sqls << sql
        end

        ActiveSupport::Notifications.subscribed(callback, "sql.active_record") do
          get field_path(field)
        end

        user_selects = sqls.select { |sql| sql.match?(/FROM ["`]users["`]/i) }
        expect(user_selects.size).to be <= 1
      end
    end

    context "存在しないidを指定したとき" do
      it "ActiveRecord::RecordNotFoundになること" do
        expect do
          get field_path(999_999_999)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
