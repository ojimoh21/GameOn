class PartySessionsController < ApplicationController
  def new
    @party_session = PartySession.new
  end

  def create
    @party_session = PartySession.new(party_session_params)
    @party_session.user = current_user
    if @party_session.save
      redirect_to party_session_path(@party_session)
    else
      render :new
    end
  end

  def index
    query_previous = "user_id = :user_id AND end_date < :date_now"
    query_upcoming = "user_id = :user_id AND start_date > :date_now"
    query_ongoing = "user_id = :user_id AND start_date < :date_now AND end_date < :date_now"
    @upcoming_party_sessions = PartySession.where(query_previous, user_id: "#{current_user.id}", date_now: "#{DateTime.now()}")
    @previous_party_sessions = PartySession.where(query_upcoming, user_id: "#{current_user.id}", date_now: "#{DateTime.now()}")
    @ongoing_party_sessions = PartySession.where(query_ongoing, user_id: "#{current_user.id}", date_now: "#{DateTime.now()}")
  end

  def party_session_params
    params.require(:party_session).permit(:title, :description, :start_date, :end_date, :start_time, :end_time, :address)
  end
end
