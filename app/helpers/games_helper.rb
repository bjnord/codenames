module GamesHelper
  def protected_who_classes(game_word, session)
    if game_word.game.spymaster?(session) || game_word.revealed?
      klass = game_word.who
    else
      klass = 'nil'
    end
    game_word.revealed? ? klass : "#{klass} unrevealed"
  end
end
