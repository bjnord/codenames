class GamesController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.js? }
  before_action :set_game, only: [:show, :get_word, :set_word, :set_who, :reveal]
  before_action :authorize_update, only: [:set_word, :set_who, :reveal]
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
    @game = Game.new(strong_params)
    @game.spymasters.build(sessionid: session.id)
    @game.save
    respond_with @game
  end

  def get_word
    if params[:game_word_id].blank?
      render status: :unprocessable_entity, js: 'ID is required', content_type: 'text/plain' and return
    end
    @game_word = GameWord.find(params[:game_word_id].to_i)
    respond_to do |format|
      format.html { render :show }  # TODO
      format.js   { render :get_word }
    end
  end

  def set_word
    if (pos = params[:position] || @game.next_position).blank?
      # need to provide params[:position] in this case
      render status: :unprocessable_entity, js: 'All words entered', content_type: 'text/plain' and return
    end
    @game_word = @game.word_at(pos.to_i)
    @game_word.position = pos
    @game_word.word = params[:word]
    if @game_word.save
      respond_to do |format|
        format.html { render :show }  # TODO
        format.js   { render :set_word }
      end
    else
      respond_to do |format|
        format.html { render :show }  # TODO
        format.js   { render status: :unprocessable_entity, js: @game_word.errors.full_messages.to_sentence, content_type: 'text/plain' }
      end
    end
  end

  def set_who
    pos_i = params[:position].present? ? params[:position].to_i : nil
    unless (@game_word = @game.word_at(pos_i)).persisted?
      render status: :unprocessable_entity, js: 'Word not found', content_type: 'text/plain' and return
    end
    @game_word.who = params[:who]
    if @game_word.save
      respond_to do |format|
        format.html { render :show }  # TODO
        format.js   { render :set_who }
      end
    else
      respond_to do |format|
        format.html { render :show }  # TODO
        format.js   { render status: :unprocessable_entity, js: @game_word.errors.full_messages.to_sentence, content_type: 'text/plain' }
      end
    end
  end

  def reveal
    pos_i = params[:position].present? ? params[:position].to_i : nil
    unless (@game_word = @game.word_at(pos_i)).persisted?
      render status: :unprocessable_entity, js: 'Word not found', content_type: 'text/plain' and return
    end
    @game_word.revealed = true
    if @game_word.save
      GameChannel.broadcast_to(@game, @game_word)
      respond_to do |format|
        format.html { render :show }  # TODO
        format.js   { render :reveal }
      end
    else
      respond_to do |format|
        format.html { render :show }  # TODO
        format.js   { render status: :unprocessable_entity, js: @game_word.errors.full_messages.to_sentence, content_type: 'text/plain' }
      end
    end
  end

private

  def strong_params
    params.require(:game).permit(:name)
  end

  def set_game
    @game = Game.includes(:game_words).find(params[:id])
  end

  def authorize_update
    if !@game.spymaster?(session)
      respond_to do |format|
        format.html { redirect_to game_url(@game), alert: t(:only_spymaster_can_update) }
        format.js   { render status: :unauthorized, js: t(:only_spymaster_can_update), content_type: 'text/plain' and return }
      end
    end
  end
end
