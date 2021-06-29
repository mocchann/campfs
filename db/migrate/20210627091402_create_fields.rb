class CreateFields < ActiveRecord::Migration[6.1]
  def change
    create_table :fields do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.string :season
      t.string :check_in_out
      t.string :place
      t.string :elevation
      t.string :section_site
      t.string :free_site
      t.string :ground
      t.string :fire
      t.string :car
      t.string :security
      t.string :trash
      t.string :bath
      t.string :toilet

      t.timestamps
    end
  end
end
