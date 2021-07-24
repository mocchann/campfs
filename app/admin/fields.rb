ActiveAdmin.register Field do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :address, :reservation, :phone_number, :business_hours, :holiday, :all_season, :season, :early_in, :early_in_description, :late_out, :late_out_description,
                :check_in, :check_out, :day_camp, :day_camp_description, :sea, :lake, :river, :mountain, :woods, :near_station, :near_station_km, :near_ic, :near_spa, :near_supermarket,
                :elevation, :section_site, :section_site_price, :section_site_size, :free_site,  :free_site_price, :free_site_size, :cancel, :ground_turf, :ground_soil, :ground_wood_deck,
                :ground_sand, :bonfire, :direct_fire, :car, :gate, :manager_resident, :manager_on_time, :security, :trash, :coin_shower, :free_shower, :washlet, :flush_toilet, :simple_toilet,
                :pets, :latitude, :longitude, :image, :place_id, :field_url, :laid_back_camp, :two_people_solo_camp
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :address, :phone_number, :season, :check_in_out, :place, :elevation, :section_site, :free_site, :ground, :fire, :car, :security, :trash, :bath, :toilet]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :reservation, as: :select, collection: ['ネット予約可', '電話予約', '予約不可', '予約無し']
      f.input :phone_number
      f.input :business_hours
      f.input :holiday
      f.input :all_season
      f.input :season
      f.input :early_in
      f.input :early_in_description
      f.input :late_out
      f.input :late_out_description
      f.input :check_in
      f.input :check_out
      f.input :day_camp
      f.input :day_camp_description
      f.input :sea
      f.input :lake
      f.input :river
      f.input :mountain
      f.input :woods
      f.input :near_station
      f.input :near_station_km
      f.input :near_ic
      f.input :near_spa
      f.input :near_supermarket
      f.input :elevation
      f.input :section_site
      f.input :section_site_price
      f.input :section_site_size
      f.input :free_site
      f.input :free_site_price
      f.input :free_site_size
      f.input :cancel
      f.input :ground_turf
      f.input :ground_soil
      f.input :ground_wood_deck
      f.input :ground_sand
      f.input :bonfire
      f.input :direct_fire
      f.input :car
      f.input :gate
      f.input :manager_resident
      f.input :manager_on_time
      f.input :trash
      f.input :coin_shower
      f.input :free_shower
      f.input :washlet
      f.input :flush_toilet
      f.input :simple_toilet
      f.input :pets
      f.input :latitude, :precision => 12, :scale => 9
      f.input :longitude, :precision => 12, :scale => 9
      f.input :image
      f.input :place_id
      f.input :field_url
      f.input :laid_back_camp
      f.input :two_people_solo_camp
    end
    f.actions
  end
end
