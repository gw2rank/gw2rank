class CreateSeasons < ActiveRecord::Migration[6.1]
  def change
    create_table :seasons do |t|
      t.string :gw_id
      t.string :name
      t.datetime :start
      t.datetime :end
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
