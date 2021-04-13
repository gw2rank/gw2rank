class CreateLadders < ActiveRecord::Migration[6.1]
  def change
    create_table :ladders do |t|
      t.references :season, null: false, foreign_key: true
      t.string :region
      t.text :json

      t.timestamps
    end
  end
end
