class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.integer :vote
      t.references :guest, null: false, foreign_key: true
      t.references :party_game, null: false, foreign_key: true
      t.timestamps
    end
  end
end
