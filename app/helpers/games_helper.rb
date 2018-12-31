module GamesHelper
  def nav_show_game
    @game && @game.persisted?
  end

  def nav_new_aclass
    (@game && @game.new_record?) ? 'active' : ''
  end
end
