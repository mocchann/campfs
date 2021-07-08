ActiveAdmin.register Field do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :address, :reservation, :phone_number, :season, :early_in_late_out, :check_in_out, :day_camp, :place, :near_ic, :near_spa, :elevation, :section_site, :free_site, :cancel, :ground, :fire, :car, :security, :trash, :bath, :toilet, :pet, :latitude, :longitude, :image
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
      f.input :reservation
      f.input :phone_number
      f.input :season
      f.input :early_in_late_out
      f.input :check_in_out
      f.input :day_camp
      f.input :place
      f.input :near_ic
      f.input :near_spa
      f.input :elevation
      f.input :section_site
      f.input :free_site
      f.input :cancel
      f.input :ground
      f.input :fire
      f.input :car
      f.input :security
      f.input :trash
      f.input :bath
      f.input :toilet
      f.input :pet
      f.input :latitude, :precision => 12, :scale => 9
      f.input :longitude, :precision => 12, :scale => 9
      f.input :image
    end
    f.actions
  end
end
