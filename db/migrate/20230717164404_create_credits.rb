class CreateCredits < ActiveRecord::Migration[6.0]
  def change
    create_table :credits do |t|
      t.references :user, foreign_key: true
      t.integer :amount, default: 0

      t.timestamps null: false
    end
  end
end
