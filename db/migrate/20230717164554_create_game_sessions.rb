class CreateGameSessions < ActiveRecord::Migration[6.0]
  def change
    create_table :game_sessions do |t|
      t.references :user, foreign_key: true
      t.integer :credits

      t.timestamps null: false
    end
  end
end
