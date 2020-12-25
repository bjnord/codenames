class PinsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.js? }
  respond_to :html, :js

  def index
    # FIXME make this a ".spymaster" scope
    @game = Game.order(created_at: :desc).where(sessionid: session.id).first
  end

  def create
  end
end
