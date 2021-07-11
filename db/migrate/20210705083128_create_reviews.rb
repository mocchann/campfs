class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :content
      t.float :rate
      t.references :user, foreign_key: true
      t.references :field, foreign_key: true

      t.timestamps
    end
  end
end
