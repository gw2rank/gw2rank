class AddAchievementCategoryReferencesToAchievements < ActiveRecord::Migration[7.0]
  def change
    add_reference :achievements, :achievement_category, null: true, foreign_key: true
  end
end
