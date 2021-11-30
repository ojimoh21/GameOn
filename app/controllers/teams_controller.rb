class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  def index
    @teams = Team.all.order("created_at DESC")
  end

  def new
    @team = Team.new
  end

  def show
  end

  def create
    @party_session = PartySession.find(params[:party_session_id])
    @party_game = PartyGame.find(params[:party_game_id])
    # party_games_in_event = PartyGame.where(party_session_id: params[:party_session_id])
    # party_game_selection = party_games_in_event.find_by(game_id: params[:game_id])
    @suggested_numplayers = Game.find_by(id: @party_game.game_id).suggested_numplayers
    confirmed_guests = Guest.where(id: Guest.where(party_session_id: 8), confirm_arrival: true)

    mix_conf = confirmed_guests.shuffle
    # Create TEAMS
    creating_teams = mix_conf.in_groups(@suggested_numplayers, false)
    creating_teams.each_with_index do |team, index|
      @team = Team.new(team_name: index, party_game: @party_game)
    end

    # CREATE TEAM MEMBERS
    confirmed_guests.each do |guest|
      @team_member = TeamMember.create(guest_id: guest.id)
    end



      if @team.save
        # @team.team_member.where(guest_id: Guest.where(id: Guest.where(party_session_id: params[:party_session_id]))
      end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:team_name, :party_game)
  end
end
