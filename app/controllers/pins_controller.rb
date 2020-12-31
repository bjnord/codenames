class PinsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.js? }
  respond_to :html, :js

  def index
    req = Rails.application.routes.recognize_path(request.referrer)
    if req[:controller] == 'games' && req[:id].present?
      @game = Game.find_by(id: req[:id].to_i)
    end
  end

  def create
    game_pin = params[:game_pin].gsub(/\D/, '')
    if @game = Game.find_by(pin: game_pin)
      @spymaster = @game.spymasters.build(sessionid: session.id)
      if @spymaster.save
        respond_to do |format|
          format.html { redirect_to @game }
          format.js { render js: "window.location='#{game_url(@game).to_s}';" }
        end
      else
        Rails.logger.error "spymaster save failed: #{@spymaster.errors.inspect}"
        flash.alert = 'Unable to update database with new spymaster'
        respond_to do |format|
          format.html { redirect_to root_url }
          format.js { render js: "window.location='#{root_url.to_s}';" }
        end
      end
    else
      Rails.logger.error "game not found for PIN: #{game_pin}"
      flash.alert = 'Invalid PIN'
      respond_to do |format|
        format.html { redirect_to root_url }
        format.js { render js: "window.location='#{root_url.to_s}';" }
      end
    end
  end
end
