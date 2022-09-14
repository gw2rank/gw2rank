class CreateAchievements < ActiveRecord::Migration[7.0]
  def change
    create_table :achievements do |t|
      t.integer :gw_id
      t.string :icon
      t.string :name
      t.string :description
      t.string :requirement
      t.string :locked_text
      t.string :gw_type
      t.string :flags, array: true
      t.json :tiers
      t.string :prerequisites, array: true
      t.json :rewards
      t.json :bits
      t.integer :point_cap

      t.timestamps
    end
  end
end
