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
    self.game_words.select{|gw| gw.position == pos }.first || self.game_words.build(position: pos)
  end

  def word_at_pos(x, y)
    word_at(y * Game::WIDTH + x)
  end

  def next_position
    has_words? ? nil : self.game_words.count
  end

  def who_error
    tally = Hash.new(0)
    self.game_words.collect{|gw| gw.who }.each{|who| tally[who] += 1 }
    if tally['assassin'] != 1
      I18n.t(:one_assassin_required)
    elsif tally['bystander'] != 7
      I18n.t(:bystanders_required, count: 7)
    elsif (tally['red'] - tally['blue']).abs != 1
      I18n.t(:blue_red_required)
    else
      nil
    end
  end
end
