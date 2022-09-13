class AddTitlesToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :titles, :json
  end
end
