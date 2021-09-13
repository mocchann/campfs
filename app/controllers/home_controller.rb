class HomeController < ApplicationController
  EACH_REGIONS = %w(北海道・東北 関東 中部 近畿 中国・四国 九州・沖縄)
  PREFS_AREA_1 = %w(北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県)
  PREFS_AREA_2 = %w(茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県)
  PREFS_AREA_3 = %w(新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県 愛知県)
  PREFS_AREA_4 = %w(三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県)
  PREFS_AREA_5 = %w(鳥取県 島根県 岡山県 広島県 山口県 徳島県 香川県 愛媛県 高知県)
  PREFS_AREA_6 = %w(福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県)

  prefs_count_area1 = Field.ransack(address_cont_any: PREFS_AREA_1).result.count
  prefs_count_area2 = Field.ransack(address_cont_any: PREFS_AREA_2).result.count
  prefs_count_area3 = Field.ransack(address_cont_any: PREFS_AREA_3).result.count
  prefs_count_area4 = Field.ransack(address_cont_any: PREFS_AREA_4).result.count
  prefs_count_area5 = Field.ransack(address_cont_any: PREFS_AREA_5).result.count
  prefs_count_area6 = Field.ransack(address_cont_any: PREFS_AREA_6).result.count

  PREFS_COUNT = [prefs_count_area1, prefs_count_area2, prefs_count_area3, prefs_count_area4, prefs_count_area5, prefs_count_area6]

  PREFS_1 = []
  PREFS_2 = []
  PREFS_3 = []
  PREFS_4 = []
  PREFS_5 = []
  PREFS_6 = []

  def top
    @fields = Field.joins(:reviews).group("field_id").order("avg(rate) desc").limit(3)

    PREFS_AREA_1.each do |prefs_area_1|
      PREFS_1 << Field.ransack(address_cont_any: "#{prefs_area_1}").result.count
    end

    PREFS_AREA_2.each do |prefs_area_2|
      PREFS_2 << Field.ransack(address_cont_any: "#{prefs_area_2}").result.count
    end

    PREFS_AREA_3.each do |prefs_area_3|
      PREFS_3 << Field.ransack(address_cont_any: "#{prefs_area_3}").result.count
    end

    PREFS_AREA_4.each do |prefs_area_4|
      PREFS_4 << Field.ransack(address_cont_any: "#{prefs_area_4}").result.count
    end

    PREFS_AREA_5.each do |prefs_area_5|
      PREFS_5 << Field.ransack(address_cont_any: "#{prefs_area_5}").result.count
    end

    PREFS_AREA_6.each do |prefs_area_6|
      PREFS_6 << Field.ransack(address_cont_any: "#{prefs_area_6}").result.count
    end
  end
end
