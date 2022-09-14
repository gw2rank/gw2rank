class CreatePlayerAchievements < ActiveRecord::Migration[7.0]
  def change
    create_table :player_achievements do |t|
      t.references :player, null: false, foreign_key: true
      t.references :achievement, null: false, foreign_key: true
      t.integer :gw_id
      t.string :bits
      t.integer :current
      t.integer :max
      t.boolean :done
      t.integer :repeated
      t.boolean :unlocked

      t.timestamps
    end
  end
end
