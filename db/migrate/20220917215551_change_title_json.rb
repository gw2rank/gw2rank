class ChangeTitleJson < ActiveRecord::Migration[7.0]
  def change
    rename_column :titles, :json, :json_en
  end
end
