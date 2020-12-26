class DeckWord < ApplicationRecord
  validates :word, presence: true
  validates :word, uniqueness: true, if: ->(o) { o.word.present? }
end
