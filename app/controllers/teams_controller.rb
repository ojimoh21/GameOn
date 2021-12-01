class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @party_game = PartyGame.find(params[:party_game_id])
    @teams = Team.where(party_game: @party_game)
  end

  def new
    @team = Team.new
  end

  def show
  end

  def create
    @party_session = PartySession.find(params[:party_session_id])
    @party_game = PartyGame.find(params[:party_game_id])
    @suggested_numplayers = Game.find_by(id: @party_game.game_id).suggested_numplayers
    confirmed_guests = Guest.where(party_session_id: params[:party_session_id], confirm_arrival: true)
    confirmed_guests_shuffled = confirmed_guests.shuffle

    # clear previously created teams for game
    Team.destroy_by(party_game: @party_game)

    # Create TEAMS
    teams = confirmed_guests_shuffled.in_groups(@suggested_numplayers, false)

    teams.each_with_index do |team, index|
      # Create teams
      @team = Team.new(team_name: index + 1, party_game: @party_game)
      @team.save || (render :index)

      # Create team members
      team.each do |member|
        @team_member = TeamMember.create(guest: member, team: @team)
        @team_member.save || (render :index)
      end
    end
    redirect_to party_session_party_game_teams_path(@party_session.id, @party_game.id)
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:team_name, :party_game)
  end
end
