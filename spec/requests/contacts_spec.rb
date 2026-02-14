require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "GET contacts#new" do
    context "未ログイン時" do
      before do
        get new_contact_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end

      it "タイトルが正しく表示されること" do
        expect(response.body).to include('お問い合わせフォーム △ TO_CAMP')
      end

      it "問い合わせフォームのiframeが表示されること" do
        expect(response.body).to include("docs.google.com/forms")
      end

      it "トップページへ戻る導線が表示されること" do
        expect(response.body).to include("トップページに戻る")
      end
    end

    context "ログイン時" do
      let(:user) { create(:user) }

      before do
        sign_in user
        get new_contact_path
      end

      it "未ログイン時と同様に200 OKで表示できること" do
        expect(response.status).to eq(200)
        expect(response.body).to include("お問い合わせフォーム")
      end
    end
  end
end
