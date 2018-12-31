class Game < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true, if: ->(o) { o.name.present? }
end
