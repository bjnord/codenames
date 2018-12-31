class Game < ApplicationRecord
  has_many :game_words, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true, if: ->(o) { o.name.present? }

  WIDTH = 5
  N_WORDS = WIDTH * WIDTH
end
