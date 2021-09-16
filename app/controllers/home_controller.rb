class HomeController < ApplicationController
  require "json"

  File.open("#{Rails.public_path}/json/pref.json") do |j|
    JSON_PREF = JSON.load(j)
  end

  File.open("#{Rails.public_path}/json/region.json") do |j|
    JSON_REGION = JSON.load(j)
  end

  File.open("#{Rails.public_path}/json/camp-commit.json") do |j|
    JSON_CAMP_COMMIT = JSON.load(j)
  end

  PREFS_1 = []
  PREFS_2 = []
  PREFS_3 = []
  PREFS_4 = []
  PREFS_5 = []
  PREFS_6 = []

  def top
    @fields = Field.joins(:reviews).group("field_id").order("avg(rate) desc").limit(3)

    prefs_count_area1 = Field.ransack(address_cont_any: JSON_PREF["PREFS_AREA_1"]).result.count
    prefs_count_area2 = Field.ransack(address_cont_any: JSON_PREF["PREFS_AREA_2"]).result.count
    prefs_count_area3 = Field.ransack(address_cont_any: JSON_PREF["PREFS_AREA_3"]).result.count
    prefs_count_area4 = Field.ransack(address_cont_any: JSON_PREF["PREFS_AREA_4"]).result.count
    prefs_count_area5 = Field.ransack(address_cont_any: JSON_PREF["PREFS_AREA_5"]).result.count
    prefs_count_area6 = Field.ransack(address_cont_any: JSON_PREF["PREFS_AREA_6"]).result.count

    @prefs_count = [ prefs_count_area1, prefs_count_area2, prefs_count_area3, prefs_count_area4, prefs_count_area5, prefs_count_area6 ]

    JSON_PREF["PREFS_AREA_1"].each do |prefs_area_1|
      PREFS_1 << Field.ransack(address_cont_any: "#{prefs_area_1}").result.count
    end

    JSON_PREF["PREFS_AREA_2"].each do |prefs_area_2|
      PREFS_2 << Field.ransack(address_cont_any: "#{prefs_area_2}").result.count
    end

    JSON_PREF["PREFS_AREA_3"].each do |prefs_area_3|
      PREFS_3 << Field.ransack(address_cont_any: "#{prefs_area_3}").result.count
    end

    JSON_PREF["PREFS_AREA_4"].each do |prefs_area_4|
      PREFS_4 << Field.ransack(address_cont_any: "#{prefs_area_4}").result.count
    end

    JSON_PREF["PREFS_AREA_5"].each do |prefs_area_5|
      PREFS_5 << Field.ransack(address_cont_any: "#{prefs_area_5}").result.count
    end

    JSON_PREF["PREFS_AREA_6"].each do |prefs_area_6|
      PREFS_6 << Field.ransack(address_cont_any: "#{prefs_area_6}").result.count
    end
  end
end
