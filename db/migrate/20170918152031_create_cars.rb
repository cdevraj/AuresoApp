class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :slug, index: true
      t.integer :max_speed

      t.timestamps null: false
    end
  end
end
