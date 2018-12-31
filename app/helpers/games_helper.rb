module GamesHelper
  def nav_show_game
    @game && @game.persisted?
  end

  def nav_new_aclass
    (@game && @game.new_record?) ? 'active' : ''
  end

  def protected_who(game_word, session)
    if game_word.game.spymaster?(session)
      game_word.who
    else
      'nil'
    end
  end
end
