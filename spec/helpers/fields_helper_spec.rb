require 'rails_helper'

RSpec.describe FieldsHelper, type: :helper do
  describe "#rating" do
    it "レビューがないとき0.0を返すこと" do
      expect(helper.rating([])).to eq(0.0)
    end

    it "レビューの平均値を小数2桁で返すこと" do
      reviews = [
        instance_double(Review, rate: 4.0),
        instance_double(Review, rate: 5.0),
        instance_double(Review, rate: 3.0),
      ]

      expect(helper.rating(reviews)).to eq(4.0)
    end

    it "丸めが必要なとき小数2桁へ丸めること" do
      reviews = [
        instance_double(Review, rate: 3.334),
        instance_double(Review, rate: 3.334),
        instance_double(Review, rate: 3.34),
      ]

      expect(helper.rating(reviews)).to eq(3.34)
    end

    it "nilや文字列が混在してもto_fで平均を返すこと" do
      reviews = [
        instance_double(Review, rate: nil),
        instance_double(Review, rate: "4.8"),
      ]

      expect(helper.rating(reviews)).to eq(2.4)
    end

    it "nilや数値だけでも例外を出さずに計算できること" do
      expect(helper.rating([nil, 3.5, 4.5])).to eq(4.0)
    end
  end

  describe "#fields_current_number" do
    it "件数が9件以上のときページ範囲を返すこと" do
      expect(helper.fields_current_number(2, 9)).to eq("10 ~ 18")
    end

    it "件数が8件以下のとき1始まりの範囲を返すこと" do
      expect(helper.fields_current_number(1, 5)).to eq("1 ~ 5")
    end

    it "3ページ目の範囲を返すこと" do
      expect(helper.fields_current_number(3, 9)).to eq("19 ~ 27")
    end
  end
end
