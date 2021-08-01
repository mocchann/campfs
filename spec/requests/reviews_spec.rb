require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  let(:user) { create(:user) }
  let(:field) { create(:field) }

  describe "口コミ投稿ページ" do
    context "口コミ投稿ページが正しく表示されること" do
      before do
        sign_in user
        get search_fields_path
        get field_path(field)
        get new_review_path, params: { field_id: field.id }
      end
      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('口コミ投稿 △ TO_CAMP')
      end
    end
  end
end
