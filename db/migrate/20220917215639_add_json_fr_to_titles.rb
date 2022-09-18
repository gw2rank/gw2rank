class AddJsonFrToTitles < ActiveRecord::Migration[7.0]
  def change
    add_column :titles, :json_fr, :json
  end
end
