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
    self.game_words.count > 0
  end

  def has_whos?
    self.game_words.select{|gw| gw.who != 'nil' }.count == Game::N_WORDS
  end

  def cell(x, y)
    self.game_words[y * Game::WIDTH + x]
  end
end
