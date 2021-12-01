class CreateTeamMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :team_members do |t|
      t.references :guest, null: false, foreign_key: true
      t.timestamps
    end
  end
end
