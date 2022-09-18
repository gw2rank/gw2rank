class RenameAchievementColumns < ActiveRecord::Migration[7.0]
  def change
    change_table :achievements do |t|
      t.rename :name, :name_en
      t.rename :description, :description_en
      t.rename :requirement, :requirement_en
      t.rename :locked_text, :locked_text_en
    end
  end
end
