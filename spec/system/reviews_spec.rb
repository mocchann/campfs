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
    subject do
      click_on "口コミを投稿する"
      fill_in "review_title", with: "ゆったり過ごせる最高のキャンプ場"
      find("img[alt='5']").click
      fill_in "review_content", with: "とても広い敷地で日本一ゆったりとキャンプができるキャンプ場！"
      click_on "保存"
    end

    context "口コミの投稿・削除" do
      it "口コミを入力・投稿したあとキャンプ場詳細ページに正しく表示されること" do
        subject
        expect(page).to have_content "4.5"
        expect(page).to have_content "ゆったり過ごせる最高のキャンプ場"
        expect(page).to have_content "4.5 / 5.0"
        expect(page).to have_content "とても広い敷地で日本一ゆったりとキャンプができるキャンプ場！"
      end
      it "投稿した口コミを削除できること" do
        subject
        click_on "削除する"
        page.driver.browser.switch_to.alert.text.should == '削除しますか?'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "口コミはありません"
      end
    end
  end

  describe "未ログイン時の投稿導線" do
    before do
      find("div[data-bs-toggle='dropdown']").click
      click_on "ログアウト"
      visit root_path
      fill_in "q[name_cont]", with: field.name
      find("#q_name_cont").send_keys :enter
      click_on "ダダッピロイッパラキャンプ場"
    end

    it "口コミ投稿ボタンからログインページへ遷移すること" do
      click_on "口コミを投稿する"

      expect(page).to have_current_path(new_user_session_path)
      expect(page).to have_content("ログイン")
    end
  end

  describe "口コミ投稿の失敗" do
    it "タイトル未入力で保存するとエラーメッセージが表示されること" do
      click_on "口コミを投稿する"
      fill_in "review_title", with: ""
      find("img[alt='5']").click
      fill_in "review_content", with: "失敗ケースのテスト"
      click_on "保存"

      expect(page).to have_content("口コミの投稿に失敗しました。空欄を埋めて下さい。")
      expect(page).to have_content("口コミ投稿")
    end
  end
end
