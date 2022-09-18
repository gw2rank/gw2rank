class CreateAchievementGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :achievement_groups do |t|
      t.string :gw_id
      t.string :name_en
      t.string :name_fr
      t.string :description_en
      t.string :description_fr
      t.integer :order
      t.string :categories_array, array: true

      t.timestamps
    end
  end
end
