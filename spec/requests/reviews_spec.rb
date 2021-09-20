require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  subject do
    get search_fields_path
    get field_path(field)
    get new_review_path, params: { field_id: field.id }
  end

  let(:user) { create(:user) }
  let(:field) { create(:field) }

  describe "GET reviews#new" do
    context "ユーザーがログインしているとき" do
      before do
        sign_in user
      end

      it "リクエストが200 OKとなること" do
        subject
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        subject
        expect(response.body).to include('口コミ投稿 △ TO_CAMP')
      end
    end

    context "ユーザーがログインしていないとき" do
      it "ログインページに遷移すること" do
        subject
        expect(response.status).to eq 302
      end
    end
  end
end
