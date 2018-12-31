class Game < ApplicationRecord
  has_many :game_words, dependent: :destroy

  validates :sessionid, :name, presence: true
  validates :name, uniqueness: true, if: ->(o) { o.name.present? }

  WIDTH = 5
  N_WORDS = WIDTH * WIDTH

  def spymaster?(session)
    self.sessionid == session.id
  end
end
