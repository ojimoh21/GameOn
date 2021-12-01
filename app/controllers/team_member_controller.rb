class TeamMemberController < ApplicationController
  before_action :find_team_member, only: %i[destroy]
  before_action :find_party, only: %i[new create]

  def index
    @team_member = TeamMember.where(team_id: params[:team_id])
  end

  def new
    # @users = User.where.not(id: current_user.id).or(User.where.not(id: Guest.where(party_session_id: params[:party_session_id].to_i).pluck(:user_id)).order(:last_name))
    @guests = Guest.where.not(id: Guest.where(party_session_id: params[:party_session_id].to_i).pluck(:id))
    @team_member = TeamMember.new
  end

  def create
    guest_ids = params[:guest].permit(user_id: [])[:user_id].reject!(&:blank?)
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
    if @guest.party_session.user_id == current_user.id
      redirect_to party_session_guests_path(@guest.party_session)
    else
      redirect_to party_sessions_path
    end
  end

  def toggle_availability
    @guest = Guest.find_by(party_session_id: params[:party_session_id], user_id: current_user.id)
    @guest.confirm_availability = !@guest.confirm_availability
    if @guest.save
      redirect_to party_session_path(@guest.party_session)
    else
      render "party_sessions/show"
    end
  end

  def toggle_arrival
    @guest = Guest.find_by(party_session_id: params[:party_session_id], user_id: current_user.id)
    @guest.confirm_arrival = !@guest.confirm_arrival
    if @guest.save
      redirect_to party_session_path(@guest.party_session)
    else
      render "party_sessions/show"
    end
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
