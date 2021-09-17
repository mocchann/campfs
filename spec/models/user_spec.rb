require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    build(:user)
  end

  it "すべてのフォームを入力しているとき登録できること" do
    subject
    expect(subject).to be_valid
  end
  it "ニックネームを入力していないとき登録できないこと" do
    subject.name = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end
  it "メールアドレスを入力していないとき登録できないこと" do
    subject.email = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end
  it "パスワードを入力していないとき登録できないこと" do
    subject.password = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end
  it "重複したメールアドレスが存在するとき登録できないこと" do
    user = create(:user)
    subject.email = user.email
    expect(subject).not_to be_valid
    expect(subject.errors[:email]).to include("はすでに存在します")
  end
  it "passwordが8文字以上であれば登録できること" do
    subject.password = "testuser"
    subject.encrypted_password = "testuser"
    expect(subject).to be_valid
  end
end
