class AddApiKeyToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :api_key, :string
  end
end
