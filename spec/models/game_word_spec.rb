require 'rails_helper'

RSpec.describe GameWord, type: :model do
  subject { build(:game_word) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "without a word" do
    let(:game_word) { build(:game_word, word: "") }

    it "should not be valid" do
      expect(game_word.save).to be_falsey
      expect(game_word.errors.added?(:word, :blank)).to be_truthy
      expect(game_word.errors.added?(:word, :taken, value: "")).not_to be_truthy
    end
  end

  context "with a non-unique word" do
    let(:game_word) { create(:game_word) }
    let(:game_word2) { build(:game_word, game: game_word.game, word: game_word.word) }

    it "should not be valid" do
      expect(game_word2.save).to be_falsey
      expect(game_word2.errors.added?(:word, :blank)).not_to be_truthy
      expect(game_word2.errors.added?(:word, :taken, value: game_word.word)).to be_truthy
    end
  end

  context "without a position" do
    let(:game_word) { build(:game_word, position: nil) }

    it "should not be valid" do
      expect(game_word).not_to be_valid
      expect(game_word.errors.added?(:position, :blank)).to be_truthy
      expect(game_word.errors.added?(:position, :numericality)).not_to be_truthy
    end
  end

  context "with an invalid position" do
    let(:game_word) { build(:game_word, position: 26) }

    it "should not be valid" do
      expect(game_word).not_to be_valid
      expect(game_word.errors.added?(:position, :blank)).not_to be_truthy
      expect(game_word.errors.added?(:position, :less_than, value: 26, count: 25)).to be_truthy
    end
  end

  context "with a non-unique position" do
    let(:game_word) { create(:game_word) }
    let(:game_word2) { build(:game_word, game: game_word.game, position: game_word.position) }

    it "should not be valid" do
      expect(game_word2.save).to be_falsey
      expect(game_word2.errors.added?(:position, :blank)).not_to be_truthy
      expect(game_word2.errors.added?(:position, :taken, value: game_word.position)).to be_truthy
    end
  end

  context "without a who" do
    let(:game_word) { build(:game_word, who: '') }

    it "should not be valid" do
      expect(game_word).not_to be_valid
      expect(game_word.errors.added?(:who, :blank)).to be_truthy
      expect(game_word.errors.added?(:who, :inclusion, value: '')).not_to be_truthy
    end
  end

  context "with an invalid who" do
    let(:game_word) { build(:game_word, who: 'xyzzy') }

    it "should not be valid" do
      expect(game_word).not_to be_valid
      expect(game_word.errors.added?(:who, :blank)).not_to be_truthy
      expect(game_word.errors.added?(:who, :inclusion, value: 'xyzzy')).to be_truthy
    end
  end
end
