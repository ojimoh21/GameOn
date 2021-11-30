require 'open-uri'
require 'json'

class GamesController < ApplicationController
  before_action :find_game, only: %i[show edit update destroy]

  def index
    @games = Game.where(user_id: current_user.id).order(created_at: :desc)
    # @user = User.where(email: "alyona_bordukova@gmail.com")
    @hotgames = Game.where(user_id: User.find_by(email: "alyona_bordukova@gmail.com").id)
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if params[:game][:image_url]
      game_image = URI.open(params[:game][:image_url])
    else
      game_image = URI.open(params[:image_url])
    end
    @game.photo.attach(io: game_image, filename: :image_url, content_type: 'image/jpg')
    @game.user = current_user
    if @game.save
      redirect_to game_path(@game)
    else
      puts "Couldn't save"
      render :new
    end
  end

  def edit; end

  def update
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      puts "Couldn't update"
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  def hot
    # retrieve the id of the game
    hot_game_id = params[:id]
    # fetch from api
    url = "https://api.boardgameatlas.com/api/search?ids=#{hot_game_id}&client_id=OShMmavExz"
    hot_game_result = JSON.parse(URI.open(url).read)
    hot_game = hot_game_result["games"].first
    # save the result in an instance variable
    @hotgame = Game.new(
      title: hot_game['name'],
      description: hot_game['description'].gsub(/<\/?[^>]+(>|$)/, ""),
      suggested_numplayers: ((hot_game["min_players"] + hot_game["max_players"]) / 2).round,
      duration: ((hot_game["min_playtime"] + hot_game["max_playtime"]) / 2).round
    )
    @game_image = hot_game['image_url']
    # use the ins var to display in the view
  end

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:title, :description, :suggested_numplayers, :duration, :photo)
  end
end
