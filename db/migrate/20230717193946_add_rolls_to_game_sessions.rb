class AddRollsToGameSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :game_sessions, :rolls, :text, array: true, default: []
  end
end
