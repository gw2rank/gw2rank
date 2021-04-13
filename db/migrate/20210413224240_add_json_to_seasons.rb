class AddJsonToSeasons < ActiveRecord::Migration[6.1]
  def change
    add_column :seasons, :json, :text
  end
end
