class CreateTitles < ActiveRecord::Migration[7.0]
  def change
    create_table :titles do |t|
      t.integer :gw_id
      t.string :name
      t.integer :achievement_gw_id
      t.json :json

      t.timestamps
    end
  end
end
