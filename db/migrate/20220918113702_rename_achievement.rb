class RenameAchievement < ActiveRecord::Migration[7.0]
  def change
    rename_column :titles, :achievement, :achievement_gw_id
  end
end
