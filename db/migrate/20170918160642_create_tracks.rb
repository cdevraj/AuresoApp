class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name, index: true
      t.string :surface_type
      t.integer :slow_factor

      t.timestamps null: false
    end
  end
end
