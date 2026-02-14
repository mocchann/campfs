require 'rails_helper'

RSpec.describe "header navigation", type: :system do
  let(:user) { create(:user) }

  it "未ログイン時はログイン導線が表示されること" do
    visit root_path

    expect(page).to have_link("ゲストログイン")
    expect(page).to have_link("ログイン")
    expect(page).to have_link("新規登録")
  end

  it "ログイン時はユーザー導線が表示されること" do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    find('input[name="commit"]').click

    expect(page).to have_content(user.name)
    find(".btn-group.dropdown .btn").click
    expect(page).to have_link("アイコン・ネーム編集")
    expect(page).to have_link("メール・パスワード編集")
    expect(page).to have_link("気になるキャンプ場リスト")
    expect(page).to have_link("ログアウト")
  end
end
