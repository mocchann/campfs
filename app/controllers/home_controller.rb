class HomeController < ApplicationController
  EACH_REGIONS = %w(北海道・東北 関東 中部 近畿 中国・四国 九州・沖縄).freeze.each(&:freeze)
  PREFS_AREA_1 = %w(北海道 青森県 岩手県 宮城県 秋田県 山形県 福島県).freeze.each(&:freeze)
  PREFS_AREA_2 = %w(茨城県 栃木県 群馬県 埼玉県 千葉県 東京都 神奈川県).freeze.each(&:freeze)
  PREFS_AREA_3 = %w(新潟県 富山県 石川県 福井県 山梨県 長野県 岐阜県 静岡県 愛知県).freeze.each(&:freeze)
  PREFS_AREA_4 = %w(三重県 滋賀県 京都府 大阪府 兵庫県 奈良県 和歌山県).freeze.each(&:freeze)
  PREFS_AREA_5 = %w(鳥取県 島根県 岡山県 広島県 山口県 徳島県 香川県 愛媛県 高知県).freeze.each(&:freeze)
  PREFS_AREA_6 = %w(福岡県 佐賀県 長崎県 熊本県 大分県 宮崎県 鹿児島県 沖縄県).freeze.each(&:freeze)

  PREFS_1 = []
  PREFS_2 = []
  PREFS_3 = []
  PREFS_4 = []
  PREFS_5 = []
  PREFS_6 = []

  BUSINESS_CONDITIONS = %w(通年営業 アーリーチェックイン可 レイトチェックアウト可 デイキャンプ可).freeze.each(&:freeze)
  BUSINESS_ID_AND_FOR = %w(switch-all-season switch-early-in switch-late-out switch-day-camp).freeze.each(&:freeze)
  LOCATION_CONDITIONS = %w(海 湖 川 山 林間).freeze.each(&:freeze)
  LOCATION_ID_AND_FOR = %w(switch-sea switch-lake switch-river switch-mountain switch-woods).freeze.each(&:freeze)
  CAMPSITE_CONDITIONS = %w(区画サイト有 フリーサイト有 芝 土 ウッドデッキ 砂 焚き火可 直火可 車の横付け可).freeze.each(&:freeze)
  CAMPSITE_ID_AND_FOR = %w(switch-section-site switch-free-site switch-ground-turf switch-ground-soil switch-ground-wood-deck switch-ground-sand switch-bonfire switch-direct-fire switch-car).freeze.each(&:freeze)
  FACILITY_CONDITIONS = %w(キャンプ場ゲート有 24時間管理人常駐 ゴミ捨て場有 コインシャワー有 無料シャワー有 ウォシュレット式トイレ 水洗式トイレ ペット可).freeze.each(&:freeze)
  FACILITY_ID_AND_FOR = %w(switch-gate switch-manager-resident switch-trash switch-coin-shower switch-free-shower switch-washlet switch-flush-toilet switch-pets).freeze.each(&:freeze)

  def top
    @fields = Field.joins(:reviews).group("field_id").order("avg(rate) desc").limit(3)

    prefs_count_area1 = Field.ransack(address_cont_any: PREFS_AREA_1).result.count
    prefs_count_area2 = Field.ransack(address_cont_any: PREFS_AREA_2).result.count
    prefs_count_area3 = Field.ransack(address_cont_any: PREFS_AREA_3).result.count
    prefs_count_area4 = Field.ransack(address_cont_any: PREFS_AREA_4).result.count
    prefs_count_area5 = Field.ransack(address_cont_any: PREFS_AREA_5).result.count
    prefs_count_area6 = Field.ransack(address_cont_any: PREFS_AREA_6).result.count

    @prefs_count = [prefs_count_area1, prefs_count_area2, prefs_count_area3, prefs_count_area4, prefs_count_area5, prefs_count_area6]

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
