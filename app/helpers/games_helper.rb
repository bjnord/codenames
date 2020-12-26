module GamesHelper
  def protected_who_classes(game_word, session)
    spymaster = game_word.game.spymaster?(session)
    if spymaster || game_word.revealed?
      klass = game_word.who
    else
      klass = 'nil'
    end
    game_word.revealed? ? (spymaster ? "#{klass} revealed" : klass) : "#{klass} unrevealed"
  end
end
