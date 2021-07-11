class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.string :name
      t.string :address
      t.string :reservation
      t.string :phone_number
      t.string :season
      t.string :early_in_late_out
      t.string :check_in_out
      t.string :day_camp
      t.string :place
      t.string :near_ic
      t.string :near_spa
      t.integer :elevation
      t.string :section_site
      t.string :free_site
      t.string :cancel
      t.string :ground
      t.string :fire
      t.string :car
      t.string :security
      t.string :trash
      t.string :bath
      t.string :toilet
      t.string :pet
      t.decimal :latitude, :precision => 12, :scale => 9
      t.decimal :longitude, :precision => 12, :scale => 9
      t.string :image
      t.string :place_id
      t.string :field_url
      
      t.timestamps
    end
  end
end
