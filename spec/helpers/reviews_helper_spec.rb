require 'rails_helper'

RSpec.describe ReviewsHelper, type: :helper do
  describe "#reviews_current_number" do
    it "件数が3件以上のときページ範囲を返すこと" do
      expect(helper.reviews_current_number(2, 3)).to eq("4 ~ 6")
    end

    it "件数が2件以下のとき1始まりの範囲を返すこと" do
      expect(helper.reviews_current_number(1, 2)).to eq("1 ~ 2")
    end

    it "3ページ目の範囲を返すこと" do
      expect(helper.reviews_current_number(3, 3)).to eq("7 ~ 9")
    end

    it "current_pageやsizeが文字列でも計算できること" do
      expect(helper.reviews_current_number("2", "3")).to eq("4 ~ 6")
    end
  end
end
