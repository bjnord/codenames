class Game < ApplicationRecord
  has_many :game_words, dependent: :destroy

  validates :sessionid, :name, presence: true
  validates :name, uniqueness: true, if: ->(o) { o.name.present? }

  WIDTH = 5
  N_WORDS = WIDTH * WIDTH

  def spymaster?(session)
    self.sessionid == session.id
  end

  def has_words?
    self.game_words.count == Game::N_WORDS
  end

  def has_whos?
    self.game_words.select{|gw| gw.who != 'nil' }.count == Game::N_WORDS
  end

  def word_at(pos)
    self.game_words.select{|gw| gw.position == pos }.first
  end

  def word_at_pos(x, y)
    word_at(y * Game::WIDTH + x)
  end

  def next_position
    has_words? ? nil : self.game_words.count
  end
end
