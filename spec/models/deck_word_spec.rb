require 'rails_helper'

RSpec.describe DeckWord, type: :model do
  subject { build(:deck_word) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "without a word" do
    let(:deck_word) { build(:deck_word, word: "") }

    it "should not be valid" do
      expect(deck_word.save).to be_falsey
      expect(deck_word.errors.added?(:word, :blank)).to be_truthy
      expect(deck_word.errors.added?(:word, :taken, value: "")).not_to be_truthy
    end
  end

  context "with a non-unique word" do
    let(:deck_word) { create(:deck_word) }
    let(:deck_word2) { build(:deck_word, word: deck_word.word) }

    it "should not be valid" do
      expect(deck_word2.save).to be_falsey
      expect(deck_word2.errors.added?(:word, :blank)).not_to be_truthy
      expect(deck_word2.errors.added?(:word, :taken, value: deck_word.word)).to be_truthy
    end
  end
end
