class GamesController < ApplicationController
  before_action :find_game, only: %i[show edit update destroy]

  def index
    @games = Game.where(user_id: current_user.id)
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

  private

  def find_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:title, :description, :suggested_numplayers, :duration, :photo)
  end
end
