class GuestsController < ApplicationController
  before_action :find_guest, only: %i[destroy]
  before_action :find_party, only: %i[new create]

  def index
    @guests = Guest.where(party_session_id: params[:party_session_id])
  end

  def new
    # @users = User.where.not(id: current_user.id).or(User.where.not(id: Guest.where(party_session_id: params[:party_session_id].to_i).pluck(:user_id)).order(:last_name))
    @users = User.where.not(id: Guest.where(party_session_id: params[:party_session_id].to_i).pluck(:user_id)).order(:last_name)
    @guest = Guest.new
  end

  def create
    guest_ids = params[:guest].permit(:user_id => [])[:user_id].reject!(&:blank?)
    guest_ids.each do |guest_id|
      user_id = User.find(guest_id)
      @guest = Guest.new
      @guest.user = user_id
      @guest.party_session = @party_session
      if @guest.save
      else
        puts "Couldn't save"
        @party_session = PartySession.find(params[:party_session_id])
        @users = User.where.not(id: current_user.id).order(:last_name)
        @guest = Guest.new
        render :index
      end
    end
    redirect_to party_session_guests_path(@guest.party_session)
  end

  def destroy
    @guest.destroy
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def find_guest
    @guest = Guest.find(params[:id])
  end

  def find_party
    @party_session = PartySession.find(params[:party_session_id])
  end
end