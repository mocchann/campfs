require 'rails_helper'

RSpec.describe "reviews", type: :system, js: true do
  let(:user) { create(:user) }
  let(:field) { create(:field) }

  before do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    find('input[name="commit"]').click
    fill_in "q[name_cont]", with: field.name
    find("#q_name_cont").send_keys :enter
    click_on "ダダッピロイッパラキャンプ場"
  end

  describe "口コミと星評価が登録できること" do
    context "口コミの投稿" do
      it "口コミを入力・投稿したあとキャンプ場詳細ページに正しく表示されること" do
        click_on "口コミを投稿する"
        fill_in "review_title", with: "ゆったり過ごせる最高のキャンプ場"
        find("img[alt='5']").click
        fill_in "review_content", with: "とても広い敷地で日本一ゆったりとキャンプができるキャンプ場！"
        click_on "保存"
        expect(page).to have_content "4.5"
        expect(page).to have_content "ゆったり過ごせる最高のキャンプ場"
        expect(page).to have_content "4.5 / 5.0"
        expect(page).to have_content "とても広い敷地で日本一ゆったりとキャンプができるキャンプ場！"
      end

      it "投稿した口コミを削除できること" do
        click_on "口コミを投稿する"
        fill_in "review_title", with: "ゆったり過ごせる最高のキャンプ場"
        find("img[alt='5']").click
        fill_in "review_content", with: "とても広い敷地で日本一ゆったりとキャンプができるキャンプ場！"
        click_on "保存"
        click_on "削除する"
        page.driver.browser.switch_to.alert.text.should == '削除しますか?'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "口コミはありません"
      end
    end
  end
end
