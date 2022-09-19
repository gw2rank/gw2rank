class AddPlayerAchievementsCountToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :player_achievements_count, :integer
  end
end
