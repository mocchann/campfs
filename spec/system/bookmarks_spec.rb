require 'rails_helper'

RSpec.describe 'bookmarks', type: :system, js: true do
  let(:user) { create(:user) }
  let(:field) { create(:field) }

  before do
    visit new_user_session_path
    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    fill_in "q[name_cont]", with: field.name
    find("#q_name_cont").send_keys :enter
    click_on "ダダッピロイッパラキャンプ場"
  end

  describe "ブックマーク機能" do
    context "気になるキャンプ場の登録・削除ができる" do
      it "ブックマークタグをクリックすると気になるキャンプ場に追加されること" do
        find('.fa-bookmark').click
        visit user_path(user)
        expect(page).to have_content "ダダッピロイッパラキャンプ場"
        expect(page).to have_content "滋賀県高島市"
        expect(page).to have_content "000-0000-0000"
      end

      it "再度ブックマークタグをクリックすると気になるキャンプ場から削除されること" do
        find('.fa-bookmark').click
        find('.fa-bookmark').click
        visit user_path(user)
        expect(page).to have_content "気になるキャンプ場や行ってみたいキャンプ場をブックマークしてみよう！"
      end
    end
  end
end
