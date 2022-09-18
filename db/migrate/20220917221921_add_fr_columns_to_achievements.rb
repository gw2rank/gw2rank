class AddFrColumnsToAchievements < ActiveRecord::Migration[7.0]
  def change
    add_column :achievements, :name_fr, :string
    add_column :achievements, :description_fr, :string
    add_column :achievements, :requirement_fr, :string
    add_column :achievements, :locked_text_fr, :string
  end
end
