require 'rails_helper'

RSpec.describe "GoogleMap", type: :system, js: true do
  let(:field) { create(:field) }

  before do
    visit root_path
    fill_in "q[name_cont]", with: field.name
    find("#q_name_cont").send_keys :enter
    click_on "ダダッピロイッパラキャンプ場"
  end

  describe "Google Map" do
    context "Google Map の動作確認" do
      it "ピンをクリックすると住所が表示されること" do
        pin = find("map#gmimap0 area", visible: false)
        pin.click
        expect(page).to have_content "住所：滋賀県高島市"
      end
    end
  end
end
