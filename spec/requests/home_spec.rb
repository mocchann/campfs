require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET home#top" do
    let!(:low_field) { create(:field, name: "ランキング低") }
    let!(:middle_field) { create(:field, name: "ランキング中") }
    let!(:high_field) { create(:field, name: "ランキング高") }
    let!(:review_user) { create(:user) }

    before do
      create(:review, field: low_field, user: review_user, rate: 1.0, title: "low", content: "low")
      create(:review, field: middle_field, user: review_user, rate: 3.0, title: "mid", content: "mid")
      create(:review, field: high_field, user: review_user, rate: 5.0, title: "high", content: "high")
    end

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

      it "口コミランキングが高評価順に表示されること" do
        high_index = response.body.index("ランキング高")
        middle_index = response.body.index("ランキング中")
        low_index = response.body.index("ランキング低")

        expect(high_index).to be < middle_index
        expect(middle_index).to be < low_index
      end

      it "地域別の件数表示が含まれること" do
        expect(response.body).to include("中国・四国")
        expect(response.body).to match(/中国・四国<br>\d+件/)
      end

      it "JSONをacceptしてもレスポンスできること" do
        get root_path, headers: { "ACCEPT" => "application/json" }

        expect(response.status).to eq(200)
      end
    end

    context "topページが正しく表示されること(ゲストユーザーログイン)" do
      before do
        post users_guest_sign_in_path
      end

      it "リクエストが302となること" do
        expect(response.status).to eq 302
      end

      it "トップページへリダイレクトすること" do
        expect(response).to redirect_to(root_path)
      end

      it "ゲストログイン成功メッセージが設定されること" do
        expect(flash[:notice]).to include("ゲストユーザーさん")
      end
    end
  end
end
