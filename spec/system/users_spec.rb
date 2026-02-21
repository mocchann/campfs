require 'rails_helper'

RSpec.describe "users", type: :system, js: true do
  let(:user) { create(:user) }

  def sign_in_as(target_user)
    visit new_user_session_path
    fill_in "user[email]", with: target_user.email
    fill_in "user[password]", with: target_user.password
    click_button "ログイン"
  end

  describe "プロフィール編集" do
    it "名前を更新できること" do
      sign_in_as(user)
      visit users_profile_path
      find("input[name='user[name]']", match: :first).set("system_updated_name")
      click_on "更新"

      expect(page).to have_current_path(users_profile_path)
      expect(page).to have_content("プロフィールを更新しました")
      expect(page).to have_css("input[name='user[name]'][value='system_updated_name']")
    end

    it "不正な名前では更新できずエラー表示されること" do
      sign_in_as(user)
      visit users_profile_path
      find("input[name='user[name]']", match: :first).set("")
      click_on "更新"

      expect(page).to have_content("プロフィールを更新できませんでした")
      expect(page).to have_current_path(users_profile_update_path)
    end
  end

  describe "ゲストユーザー制限" do
    before do
      visit root_path
      within("header") do
        click_on "ゲストログイン"
      end
    end

    it "プロフィール更新は許可されずトップへ戻されること" do
      visit users_profile_path
      find("input[name='user[name]']", match: :first).set("guest_hacked")
      click_on "更新"

      expect(page).to have_current_path(root_path)
      expect(page).to have_content("編集・削除などができない")
    end
  end
end
