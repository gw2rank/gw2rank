class AddNameFrToTitles < ActiveRecord::Migration[7.0]
  def change
    add_column :titles, :name_fr, :string
  end
end
