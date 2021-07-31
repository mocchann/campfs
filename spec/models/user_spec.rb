require 'rails_helper'

RSpec.describe User, type: :model do

  it "すべてのフォームを入力しているとき登録できること" do
    user = build(:user)
    expect(user).to be_valid
  end

  it "ニックネームを入力していないとき登録できないこと" do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスを入力していないとき登録できないこと"  do
    user = build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください", "は不正な値です")
  end

  it "パスワードを入力していないとき登録できないこと" do
    user = build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("を入力してください")
  end

  it "重複したメールアドレスが存在するとき登録できないこと" do
    user = create(:user)
    another_user = build(:user, email: user.email)
    another_user.valid?
    expect(another_user.errors[:email]).to include("はすでに存在します")
  end

  it "passwordが8文字以上であれば登録できること" do
    user = build(:user, password: "testuser", encrypted_password: "testuser")
    expect(user).to be_valid
  end
end
