class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.string :home_type
      t.integer :accommodate
      t.string :listing_name
      t.text :summary
      t.string :address
      t.boolean :is_toys
      t.boolean :is_treats
      t.boolean :is_food
      t.boolean :is_garden
      t.boolean :is_exercise
      t.integer :price
      t.boolean :active
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
