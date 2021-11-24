class PartySessionsController < ApplicationController
  def new
    @party_session = PartySession.new
  end

  def create
    @party_session = PartySession.new(party_session_params)
    if @party_session.save
      redirect_to party_session_path(@party_session)
    else
      render :new
    end
  end

  def party_session_params
    params.require(:party_session).permit(:title, :description, :start_date, :end_date, :start_time, :end_time, :location)
  end
end
