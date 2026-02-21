FactoryBot.define do
  factory :field do |d|
    d.name { "ダダッピロイッパラキャンプ場" }
    d.address { "岡山県真庭市" }
    d.reservation { "ネット予約可" }
    d.phone_number { "000-0000-0000" }
    d.all_season { "true" }
    d.early_in { "true" }
    d.late_out { "false" }
    d.day_camp { "true" }
    d.sea { "false" }
    d.lake { "false" }
    d.river { "false" }
    d.mountain { "true" }
    d.woods { "true" }
    d.near_station_km { "1" }
    d.elevation { "777" }
    d.section_site { "false" }
    d.free_site { "true" }
    d.cancel { "false" }
    d.ground_turf { "ture" }
    d.ground_soil { "true" }
    d.ground_wood_deck { "false" }
    d.ground_sand { "false" }
    d.bonfire { "true" }
    d.direct_fire { "true" }
    d.car { "true" }
    d.gate { "true" }
    d.manager_resident { "true" }
    d.manager_on_time { "false" }
    d.trash { "true" }
    d.coin_shower { "true" }
    d.free_shower { "false" }
    d.washlet { "true" }
    d.flush_toilet { "false" }
    d.simple_toilet { "false" }
    d.pets { "true" }
    d.latitude { "35.496459222" }
    d.longitude { "136.033575333" }
    sequence(:place_id) { |n| "bigcamp_#{n}" }
    d.field_url { "dadappiroi" }
    d.laid_back_camp { "true" }
    d.two_people_solo_camp { "true" }
  end
end
