class VotesController < ApplicationController
  def index
    @party_session = PartySession.find(params[:party_session_id])
  end

  def create
    @party_session = PartySession.find(params[:party_session_id])
    @party_game = PartyGame.find(params[:party_game_id])
    @vote = Vote.new(vote_params)
    @vote.guest = Guest.where(party_session_id: params[:party_session_id]).where(user_id: current_user.id).first
    @vote.party_game = @party_game
    if @vote.save!
      puts "Saved!"
      redirect_to party_session_party_games_path
    else
      puts "It didn't save!"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(:vote)
  end
end
