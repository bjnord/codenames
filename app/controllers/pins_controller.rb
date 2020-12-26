class PinsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.js? }
  respond_to :html, :js

  def index
    @game = Game.order(created_at: :desc).joins(:spymasters).where('spymasters.sessionid = ?', session.id).first
  end

  def create
  end
end
