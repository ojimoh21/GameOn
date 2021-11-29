class PartySessionsController < ApplicationController
  before_action :set_party_session, only: %i[show edit update destroy]

  def new
    @party_session = PartySession.new
  end

  def create
    @party_session = PartySession.new(party_session_params)
    @party_session.user = current_user
    if @party_session.save
      chatroom = Chatroom.new
      chatroom.name = @party_session.title
      chatroom.party_session = @party_session
      chatroom.save
      guest = Guest.new
      guest.user = current_user
      guest.confirm_availability = true
      guest.confirm_arrival = true
      guest.party_session = @party_session
      guest.save
      redirect_to party_session_path(@party_session)
    else
      render :new
    end
  end

  def index
    # use this when guest table is done and add logic for when user is a guest
    # query_previous = "user_id = :user_id AND end_date < :date_now"
    # @upcoming_party_sessions = PartySession.where(query_upcoming, user_id: "#{current_user.id}", date_now: "#{DateTime.now()}")

    query_previous = "end_date < :date_now"
    query_upcoming = "start_date > :date_now"
    query_ongoing = "start_date < :date_now AND end_date > :date_now"
    @upcoming_party_sessions = PartySession.where(query_upcoming, date_now: "#{DateTime.now()}")
    @previous_party_sessions = PartySession.where(query_previous, date_now: "#{DateTime.now()}")
    @ongoing_party_sessions = PartySession.where(query_ongoing, date_now: "#{DateTime.now()}")
  end

  def show
    party = @party_session.geocode
    @markers = [{ lat: party[0], lng: party[1] }]
  end

  def edit; end

  def update
    if @party_session.update(party_session_params)
      redirect_to party_session_path(@party_session)
    else
      render :update
    end
  end

  def destroy
    if @party_session.destroy
      redirect_to party_sessions_path
    else
      render :show
    end
  end

  private

  def party_session_params
    params.require(:party_session).permit(:title, :description, :start_date, :end_date, :start_time, :end_time, :address)
  end

  def set_party_session
    @party_session = PartySession.find(params[:id])
  end
end
