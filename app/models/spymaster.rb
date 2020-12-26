class Spymaster < ApplicationRecord
  belongs_to :game

  validates :sessionid, presence: true
end
