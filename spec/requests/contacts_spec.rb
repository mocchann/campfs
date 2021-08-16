require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  describe "問い合わせフォーム" do
    context "問い合わせフォームが正しく表示されること" do
      before do
        get new_contact_path
      end

      it "リクエストが200 OKとなること" do
        expect(response.status).to eq 200
      end
      it "タイトルが正しく表示されること" do
        expect(response.body).to include('お問い合わせフォーム △ TO_CAMP')
      end
    end
  end
end
