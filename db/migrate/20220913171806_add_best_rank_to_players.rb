class AddBestRankToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :best_rank, :integer
  end
end
