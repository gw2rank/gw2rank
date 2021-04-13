class AddPublishedToSeasons < ActiveRecord::Migration[6.1]
  def change
    add_column :seasons, :published, :boolean, default: true
  end
end
