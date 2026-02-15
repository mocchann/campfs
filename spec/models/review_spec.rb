require 'rails_helper'

RSpec.describe Review, type: :model do
  subject do
    build(:review)
  end

  it "すべてのフォームを入力しているとき登録できること" do
    expect(subject).to be_valid
  end
  it "タイトルを入力していないとき登録できないこと" do
    subject.title = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end
  it "星評価を入力していないとき登録できないこと" do
    subject.rate = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end
  it "口コミ内容を入力していないとき登録できないこと" do
    subject.content = nil
    expect(subject).not_to be_valid
    expect(subject.errors).not_to be_empty
  end

  it "星評価が0.5未満だと登録できないこと" do
    subject.rate = 0.4
    expect(subject).not_to be_valid
    expect(subject.errors[:rate]).to be_present
  end

  it "星評価が0.5なら登録できること" do
    subject.rate = 0.5
    expect(subject).to be_valid
  end

  it "星評価が5を超えると登録できないこと" do
    subject.rate = 5.1
    expect(subject).not_to be_valid
    expect(subject.errors[:rate]).to be_present
  end

  it "星評価が5.0なら登録できること" do
    subject.rate = 5.0
    expect(subject).to be_valid
  end
end
