class PartySessionsController < ApplicationController
  before_action :set_party_session, only: %i[show edit update destroy]

  def new
    @party_session = PartySession.new
  end

  def create
    @party_session = PartySession.new(party_session_params)
    @party_session.user = current_user
    if @party_session.save
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
    # query_previous = "guests.user_id = guests.user_id AND end_date < :date_now"
    # query_upcoming = "guests.user_id = guests.user_id AND start_date > :date_now"
    # query_ongoing = "guests.user_id = guests.user_id AND start_date < :date_now AND end_date > :date_now"
    # @upcoming_party_sessions = PartySession.joins(:guests).where(query_upcoming, user_id: "#{current_user.id}", date_now: "#{DateTime.now()}")
    # @previous_party_sessions = PartySession.joins(:guests).where(query_previous, user_id: "#{current_user.id}", date_now: "#{DateTime.now()}")
    # @ongoing_party_sessions = PartySession.joins(:guests).where(query_ongoing, user_id: "#{current_user.id}", date_now: "#{DateTime.now()}")
    @ongoing_party_sessions = []
    @upcoming_party_sessions = []
    @previous_party_sessions = []
    date_now = DateTime.now
    current_user.guests.each do |guest|
      if guest.party_session.end_date < date_now
        @previous_party_sessions << guest.party_session
      elsif guest.party_session.start_date > date_now
        @upcoming_party_sessions << guest.party_session
      else
        @ongoing_party_sessions << guest.party_session
      end
    end
  end

  def show
    @guest = current_user.guests.find_by(party_session_id: @party_session.id)
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
