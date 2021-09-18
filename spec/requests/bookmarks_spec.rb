require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  subject do
    get user_path(user)
  end

  describe "GET users#show" do
    context "ユーザーがログインしているとき" do
      let(:user) { create(:user) }

      before do
        sign_in user
      end

      it "リクエストが200 OKとなること" do
        subject
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        subject
        expect(response.body).to include('気になるキャンプ場 △ TO_CAMP')
      end
    end

    context "ユーザーがログインしていないとき" do
      let(:user) { create(:user) }

      it "リクエストが302となること" do
        subject
        expect(response.status).to eq 302
      end
    end
  end
end
