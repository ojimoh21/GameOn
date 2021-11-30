class AddTeamToTeamMember < ActiveRecord::Migration[6.0]
  def change
    add_reference :team_members, :team, foreign_key: true, null: false
  end
end
