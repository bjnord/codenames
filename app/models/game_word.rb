class GameWord < ApplicationRecord
  belongs_to :game

  WHO_KINDS = ['nil', 'red', 'blue', 'bystander', 'assassin']

  validates :word, :position, :who, presence: true
  validates :word, uniqueness: { scope: :game }, if: ->(o) { o.game.present? && o.word.present? }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: Game::N_WORDS }, if: ->(o) { o.position.present? }
  validates :position, uniqueness: { scope: :game }, if: ->(o) { o.game.present? && o.position.present? }
  validates :who, inclusion: { in: WHO_KINDS }, if: ->(o) { o.who.present? }

  def revealed?
    self.revealed
  end
end
