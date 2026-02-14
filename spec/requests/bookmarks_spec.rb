require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  describe "GET users#show" do
    context "ユーザーがログインしているとき" do
      let(:user) { create(:user) }

      before do
        sign_in user
        get user_path(user)
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('気になるキャンプ場 △ TO_CAMP')
      end
    end

    context "ユーザーがログインしていないとき" do
      let(:user) { create(:user) }

      before { get user_path(user) }

      it "リクエストが302となること" do
        expect(response.status).to eq 302
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST bookmarks#create" do
    let(:user) { create(:user) }
    let(:field) { create(:field) }

    context "ユーザーがログインしているとき" do
      before { sign_in user }

      it "ブックマークを作成できること" do
        expect do
          post bookmarks_path, params: { field_id: field.id }
        end.to change(Bookmark, :count).by(1)

        expect(response).to redirect_to(field_path(field))
      end

      it "同じキャンプ場を重複ブックマークできないこと" do
        create(:bookmark, user: user, field: field)

        expect do
          post bookmarks_path, params: { field_id: field.id }
        end.not_to change(Bookmark, :count)

        expect(response).to redirect_to(field_path(field))
      end

      it "js形式でもブックマークを作成できること" do
        expect do
          post bookmarks_path(format: :js), params: { field_id: field.id }
        end.to change(Bookmark, :count).by(1)

        expect(response.status).to eq(200)
      end

    end

    context "ユーザーがログインしていないとき" do
      it "ログインページにリダイレクトすること" do
        post bookmarks_path, params: { field_id: field.id }

        expect(response).to redirect_to(new_user_session_path)
      end

      it "不正field_idでも先にログインページにリダイレクトすること" do
        post bookmarks_path, params: { field_id: 999_999_999 }

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "存在しないfield_idを指定したとき" do
      before { sign_in user }

      it "ActiveRecord::RecordNotFoundになること" do
        expect do
          post bookmarks_path, params: { field_id: 999_999_999 }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe "DELETE bookmarks#destroy" do
    let(:user) { create(:user) }
    let(:field) { create(:field) }
    let!(:bookmark) { create(:bookmark, user: user, field: field) }

    context "ユーザーがログインしているとき" do
      before { sign_in user }

      it "自分のブックマークを削除できること" do
        expect do
          delete bookmark_path(bookmark), params: { field_id: field.id }
        end.to change(Bookmark, :count).by(-1)

        expect(response).to redirect_to(field_path(field))
      end

      it "他ユーザーのブックマークIDは削除できないこと" do
        other_user = create(:user)
        other_bookmark = create(:bookmark, user: other_user, field: field)

        expect do
          delete bookmark_path(other_bookmark), params: { field_id: field.id }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "js形式でもブックマークを削除できること" do
        expect do
          delete bookmark_path(bookmark, format: :js), params: { field_id: field.id }
        end.to change(Bookmark, :count).by(-1)

        expect(response.status).to eq(200)
      end
    end

    context "ユーザーがログインしていないとき" do
      it "ログインページにリダイレクトすること" do
        delete bookmark_path(bookmark), params: { field_id: field.id }

        expect(response).to redirect_to(new_user_session_path)
      end

      it "不正idでも先にログインページにリダイレクトすること" do
        delete bookmark_path(999_999_999), params: { field_id: field.id }

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
