require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  let(:user) { create(:user) }

  describe "気になるキャンプ場ページ" do
    context "気になるキャンプ場ページが正しく表示されること" do
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
  end
end
