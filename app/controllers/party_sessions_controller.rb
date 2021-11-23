class PartySessionsController < ApplicationController
  def new
    @party_session = PartySession.new
  end

  def create
    raise
  end

  def party_session_params
    params.require(:party_session).permit(:title, :description, :start_date, :end_date, :start_time, :end_time, :location)
  end
end
