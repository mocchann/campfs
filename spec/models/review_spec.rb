require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:user) { create(:user) }
  let(:field) { create(:field) }
  let(:review) { create(:review) }

  it "すべてのフォームを入力しているとき登録できること" do
    expect(create(:review)).to be_valid
  end

  it "タイトルを入力していないとき登録できないこと" do
    review.title = nil
    review.valid?
    expect(review.errors[:title]).to include("を入力してください")
  end

  it "星評価を入力していないとき登録できないこと" do
    review.rate = nil
    review.valid?
    expect(review.errors[:rate]).to include("を入力してください", "は数値で入力してください")
  end

  it "口コミ内容を入力していないとき登録できないこと" do
    review.content = nil
    review.valid?
    expect(review.errors[:content]).to include("を入力してください")
  end
end
