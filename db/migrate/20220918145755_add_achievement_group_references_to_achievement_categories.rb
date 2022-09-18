class AddAchievementGroupReferencesToAchievementCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :achievement_categories, :achievement_group, null: true, foreign_key: true
  end
end
