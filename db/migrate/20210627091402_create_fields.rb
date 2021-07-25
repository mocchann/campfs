class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.string  :name
      t.string  :address
      t.string  :reservation
      t.string  :phone_number
      t.string  :business_hours
      t.string  :holiday
      t.boolean :all_season, default: false
      t.string  :season
      t.boolean :early_in, default: false
      t.string  :early_in_description
      t.boolean :late_out, default: false
      t.string  :late_out_description
      t.string  :check_in
      t.string  :check_out
      t.boolean :day_camp, default: false
      t.string  :day_camp_description
      t.boolean :sea, default: false
      t.boolean :lake, default: false
      t.boolean :river, default: false
      t.boolean :mountain, default: false
      t.boolean :woods, default: false
      t.string  :near_station
      t.integer :near_station_km
      t.string  :near_ic
      t.string  :near_spa
      t.string  :near_supermarket
      t.integer :elevation
      t.boolean :section_site, default: false
      t.string  :section_site_price
      t.string  :section_site_size
      t.boolean :free_site, default: false
      t.string  :free_site_price
      t.string  :free_site_size
      t.boolean :cancel, default: false
      t.boolean :ground_turf, default: false
      t.boolean :ground_soil, default: false
      t.boolean :ground_wood_deck, default: false
      t.boolean :ground_sand, default: false
      t.boolean :bonfire, default: false
      t.boolean :direct_fire, default: false
      t.boolean :car, default: false
      t.boolean :gate, default: false
      t.boolean :manager_resident, default: false
      t.boolean :manager_on_time, default: false
      t.boolean :trash, default: false
      t.boolean :coin_shower, default: false
      t.boolean :free_shower, default: false
      t.boolean :washlet, default: false
      t.boolean :flush_toilet, default: false
      t.boolean :simple_toilet, default: false
      t.boolean :pets, default: false
      t.decimal :latitude, :precision => 12, :scale => 9
      t.decimal :longitude, :precision => 12, :scale => 9
      t.string  :image
      t.string  :place_id
      t.string  :field_url
      t.boolean :laid_back_camp, default: false
      t.boolean :two_people_solo_camp, default: false

      t.timestamps
    end
  end
end
