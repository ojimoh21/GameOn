class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams do |t|
      t.string :team_name
      t.references :party_game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
