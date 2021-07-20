ActiveAdmin.register Field do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :address, :reservation, :phone_number, :season, :early_in_late_out, :check_in_out, :day_camp, :place, :near_ic, :near_spa, :near_supermarket, :elevation, :section_site, :free_site, :cancel, :ground, :bonfire, :direct_fire, :car, :security, :trash, :bath, :toilet, :pets, :latitude, :longitude, :image, :place_id, :field_url
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
      f.input :reservation, as: :select, collection: ['ネット予約可', '電話予約', '予約不可', '予約必要無し']
      f.input :phone_number
      f.input :season
      f.input :early_in_late_out
      f.input :check_in_out
      f.input :day_camp
      f.input :place, as: :select, collection: ['山', '川', '海', '湖']
      f.input :near_ic
      f.input :near_spa
      f.input :near_supermarket
      f.input :elevation
      f.input :section_site
      f.input :free_site
      f.input :cancel, as: :select, collection: ['キャンセル料/有', 'キャンセル料/無']
      f.input :ground, as: :select, collection: ['土', '芝', 'ウッドデッキ', '芝・土']
      f.input :bonfire
      f.input :direct_fire
      f.input :car
      f.input :security
      f.input :trash, as: :select, collection: ['ゴミ捨て場/有', 'ゴミ捨て場/無', '持ち帰り']
      f.input :bath, as: :select, collection: ['コインシャワー', '簡易シャワー', '入浴設備/無']
      f.input :toilet, as: :select, collection: ['ウォシュレット', '無', '簡易トイレ']
      f.input :pets
      f.input :latitude, :precision => 12, :scale => 9
      f.input :longitude, :precision => 12, :scale => 9
      f.input :image
      f.input :place_id
      f.input :field_url
    end
    f.actions
  end
end
