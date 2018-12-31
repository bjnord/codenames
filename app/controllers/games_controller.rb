class GamesController < ApplicationController
  respond_to :html

  def index
    @games = Game.where('created_at > ?', Time.now - 2.days).order(created_at: :desc)
  end

  def show
    @game = Game.includes(:game_words).find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(strong_params.merge(sessionid: session.id))
    respond_with @game
  end

private

  def strong_params
    params.require(:game).permit(:name)
  end
end
