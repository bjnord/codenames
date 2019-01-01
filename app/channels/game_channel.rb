class GameChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.debug "game_channel#subscribed got id=#{params[:id]}"
    if game = Game.find(params[:id])
      stream_for game
      Rails.logger.debug "game_channel#subscribed streaming"
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
