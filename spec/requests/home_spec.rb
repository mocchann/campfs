require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "topページ" do
    context "topページが正しく表示されること" do
      before do
        get root_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('TO_CAMP')
      end
    end

    context "topページが正しく表示されること(ゲストユーザーログイン)" do
      before do
        post users_guest_sign_in_path
      end

      it "リクエストが302となること" do
        expect(response.status).to eq 302
      end
    end
  end
end
