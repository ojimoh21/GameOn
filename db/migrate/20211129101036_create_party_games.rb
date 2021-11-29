class CreatePartyGames < ActiveRecord::Migration[6.0]
  def change
    create_table :party_games do |t|
      t.references :game, null: false, foreign_key: true
      t.references :party_session, null: false, foreign_key: true
      t.timestamps
    end
  end
end
