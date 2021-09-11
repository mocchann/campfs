class HomeController < ApplicationController
  def top
    @fields = Field.joins(:reviews).group("field_id").order("avg(rate) desc").limit(3)
    @field_area1_count = Field.ransack(address_cont_any: ["北海道", "青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県"]).result.count
    @field_area2_count = Field.ransack(address_cont_any: ["茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", "神奈川県"]).result.count
    @field_area3_count = Field.ransack(address_cont_any: ["新潟県‎", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", "静岡県", "愛知県"]).result.count
    @field_area4_count = Field.ransack(address_cont_any: ["三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県"]).result.count
    @field_area5_count = Field.ransack(address_cont_any: ["鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", "愛媛県", "高知県"]).result.count
    @field_area6_count = Field.ransack(address_cont_any: ["福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"]).result.count
    # @pref_33 = Field.ransack(address_cont_any: "岡山県").result.count
  end
end
