class GamesController < ApplicationController
  def index
    @games = Game.where('created_at > ?', Time.now - 2.days).order(created_at: :desc)
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    if @game = Game.create(strong_params.merge(sessionid: session.id))
      redirect_to game_path(@game)
    else
      render :new
    end
  end

private

  def strong_params
    params.require(:game).permit(:name)
  end
end
