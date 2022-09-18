class ChangeTitleName < ActiveRecord::Migration[7.0]
  def change
    rename_column :titles, :name, :name_en
  end
end
