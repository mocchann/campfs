require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:contact) { create(:contact) }

  it "すべてのフォームを入力しているとき登録できること" do
    expect(create(:contact)).to be_valid
  end

  it "お名前を入力していないとき登録できないこと" do
    contact.name = nil
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
  end

  it "メールアドレスを入力していないとき登録できないこと" do
    contact.email = nil
    contact.valid?
    expect(contact.errors[:email]).to include("を入力してください", "は不正な値です")
  end

  it "内容を入力していないとき登録できないこと" do
    contact.message = nil
    contact.valid?
    expect(contact.errors[:message]).to include("を入力してください")
  end
end
