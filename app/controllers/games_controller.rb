class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.js? && !Rails.env.production? }
  before_action :set_game, only: [:show, :set_word]
  respond_to :html, :js

  def index
    @games = Game.where('created_at > ?', Time.now - 2.days).order(created_at: :desc)
  end

  def show
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(strong_params.merge(sessionid: session.id))
    respond_with @game
  end

  def set_word
    if !@game.spymaster?(session) && Rails.env.production?
      render status: :unauthorized, js: 'Unauthorized', content_type: 'text/plain' and return
    elsif !(pos = params[:position] || @game.next_position)
      # need to provide params[:position] in this case
      render status: :unprocessable_entity, js: 'All words entered', content_type: 'text/plain' and return
    end
    @game_word = @game.word_at(pos.to_i) || @game.game_words.new
    @game_word.position = pos
    @game_word.word = params[:word]
    if @game_word.save
      render 'set_word'
    else
      render status: :unprocessable_entity, js: @game_word.errors.full_messages.to_sentence, content_type: 'text/plain'
    end
  end

private

  def strong_params
    params.require(:game).permit(:name)
  end

  def set_game
    @game = Game.includes(:game_words).find(params[:id])
  end
end
