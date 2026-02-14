require 'rails_helper'

RSpec.describe "users", type: :system, js: true do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    find('input[name="commit"]').click
  end

  describe "プロフィール編集" do
    it "名前を更新できること" do
      visit users_profile_path
      fill_in "user[name]", with: "system_updated_name"
      click_on "更新"

      expect(page).to have_current_path(users_profile_path)
      expect(page).to have_content("プロフィールを更新しました")
      expect(page).to have_field("user[name]", with: "system_updated_name")
    end

    it "不正な名前では更新できずエラー表示されること" do
      visit users_profile_path
      fill_in "user[name]", with: ""
      click_on "更新"

      expect(page).to have_content("プロフィールを更新できませんでした")
      expect(page).to have_current_path(users_profile_update_path)
    end
  end

  describe "ゲストユーザー制限" do
    before do
      find("div[data-bs-toggle='dropdown']").click
      click_on "ログアウト"
      click_on "ゲストログイン"
    end

    it "プロフィール更新は許可されずトップへ戻されること" do
      visit users_profile_path
      fill_in "user[name]", with: "guest_hacked"
      click_on "更新"

      expect(page).to have_current_path(root_path)
      expect(page).to have_content("編集・削除などができない")
    end
  end
end
