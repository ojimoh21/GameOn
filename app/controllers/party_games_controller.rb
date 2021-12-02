class PartyGamesController < ApplicationController
  before_action :find_party_game, only: %i[destroy]
  before_action :find_party, only: %i[new create]

  def index
    @party_games = PartyGame.where(party_session_id: params[:party_session_id])
    @party_session = PartySession.find(params[:party_session_id])
  end

  def show
    @party_games = PartyGame.where(party_session_id: params[:party_session_id])
    @party_game = PartyGame.find_by(id: params[:id], party_session_id: params[:party_session_id])
    @party_session = @party_game.party_session
    @votes = 0
    @party_game.votes.each do |vote|
      @votes += vote.vote
    end
    @vote = @party_game.votes.build
  end

  def new
    if params[:query].present?
      @games = Game.where("title ILIKE ?", "%#{params[:query]}%").where(user_id: current_user.id)
    else
      @games = Game.where.not(id: PartyGame.where(party_session_id: params[:party_session_id].to_i).pluck(:game_id)).where(user_id: current_user.id)
    end
    @party_game = PartyGame.new
  end

  def create
    party_games_ids = params[:party_game].permit(game_id: [])[:game_id].reject!(&:blank?)
    party_games_ids.each do |party_game_id|
      game_id = Game.find(party_game_id)
      @party_game = PartyGame.new
      @party_game.game = game_id
      @party_game.party_session = @party_session
      if @party_game.save
      else
        puts "Couldn't save"
        @party_session = PartySession.find(params[:party_session_id])
        @games = Game.where.not(id: current_user.id)
        @party_game = PartyGame.new
        render :index
      end
    end
    redirect_to party_session_party_games_path(@party_game.party_session)
  end

  def destroy
    @party_game.destroy
    redirect_to party_session_party_games_path(@party_game.party_session_id)
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def find_party_game
    @party_game = PartyGame.find(params[:id])
  end

  def find_party
    @party_session = PartySession.find(params[:party_session_id])
  end
end
