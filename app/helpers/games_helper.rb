module GamesHelper
  def nav_show_game
    @game && @game.persisted?
  end

  def nav_new_aclass
    (@game && @game.new_record?) ? 'active' : ''
  end

  def protected_who_classes(game_word, session)
    if game_word.game.spymaster?(session) || game_word.revealed?
      klass = game_word.who
    else
      klass = 'nil'
    end
    game_word.revealed? ? klass : "#{klass} unrevealed"
  end
end
