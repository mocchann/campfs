require 'rails_helper'

RSpec.describe "Fields", type: :request do
  let(:field) { create(:field) }

  describe "検索結果ページ" do
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
  end

  describe "キャンプ場詳細ページ" do
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
  end
end
