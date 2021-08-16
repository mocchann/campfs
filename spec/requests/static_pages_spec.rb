require 'rails_helper'

RSpec.describe "StaticPages", type: :request do
  describe "利用規約・プライバシーポリシー" do
    context "利用規約が正しく表示されること" do
      before do
        get static_pages_terms_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('利用規約 △ TO_CAMP')
      end
    end
    context "プライバシーポリシーが正しく表示されること" do
      before do
        get static_pages_privacy_policy_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('プライバシーポリシー △ TO_CAMP')
      end
    end
  end
end
