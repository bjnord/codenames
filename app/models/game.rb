class Game < ApplicationRecord
  has_many :game_words, dependent: :destroy
  has_many :spymasters, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true, if: ->(o) { o.name.present? }

  before_create :create_pin

  attr_accessor :starts

  WIDTH = 5
  N_WORDS = WIDTH * WIDTH

  def spymaster?(session)
    self.spymasters.where(sessionid: session.id).present?
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

  def unrevealed_for(who)
    tally = Hash.new(0)
    self.game_words.collect{|gw| gw.revealed? ? 'nil' : gw.who }.each{|who| tally[who] += 1 }
    tally[who]
  end

  def dashed_pin
    "#{self.pin[0..2]}-#{self.pin[3..-1]}"
  end

  def pick_words_from_deck
    deck_count = DeckWord.count
    (0..N_WORDS-1).each do |pos|
      if deck_count < 1
        Rails.logger.warning "deck exhausted for game #{game.id} #{game.name}"
        return false
      end
      # TODO is there a more efficient way to get word at position?
      deck_i = Random.rand(deck_count) + 1
      unless dw = DeckWord.limit(deck_i).last
        Rails.logger.error "unable to get deck word #{deck_i}/#{deck_count}"
        return false
      end
      dw.destroy
      if dw.persisted?
        raise "DeckWord #{dw.id} #{dw.word} still persisted after destroy"
      end
      gw = self.game_words.build(word: dw.word, position: pos)
      if !gw.save
        Rails.logger.error "error saving deck word #{gw.word}: #{gw.errors.inspect}"
        return false
      end
      deck_count -= 1
    end
    true
  end

  def set_whos
    word_count = self.game_words.count
    if word_count < N_WORDS
        Rails.logger.warning "must have #{N_WORDS} words for game #{game.id} #{game.name}"
        return false
    end
    words = self.game_words.to_a
    whos = %w{
      bystander bystander bystander red red blue blue red red blue blue
      bystander bystander bystander blue blue red red blue blue red red
      assassin bystander
    }
    if self.starts != 'blue' && self.starts != 'red'
      self.starts = ['blue', 'red'][Random.rand(2)]
      Rails.logger.debug "coin toss for game #{self.id} #{self.name}: #{self.starts} starts"
    end
    whos << self.starts
    while words.present?
      i = Random.rand(words.count)
      if words[i].update(who: whos.shift)
        words.delete_at(i)
      else
        Rails.logger.error "error updating who for word #{words[i].id}: #{words[i].errors.inspect}"
        return false
      end
    end
    true
  end

protected

  def create_pin
    self.pin = Random.rand(1_000_000).to_s.rjust(6, '0')
  end
end
