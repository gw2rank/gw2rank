class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.string :igname
      t.integer :best_rating, default: 0
      t.integer :best_rating_season_id

      t.timestamps
    end
    add_index :players, :igname, unique: true
  end
end
