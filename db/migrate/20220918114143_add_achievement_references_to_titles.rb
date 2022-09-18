class AddAchievementReferencesToTitles < ActiveRecord::Migration[7.0]
  def change
    add_reference :titles, :achievement, null: true, foreign_key: true
  end
end
