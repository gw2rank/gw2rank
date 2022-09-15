class AddUserReferencesToPlayers < ActiveRecord::Migration[7.0]
  def change
    add_reference :players, :user, null: true, foreign_key: true
  end
end
