require 'rails_helper'

RSpec.describe GameWord, type: :model do
  subject { build(:game_word) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "without a word" do
    let(:game_word) { build(:game_word, word: nil) }

    it "should not be valid" do
      expect(game_word).not_to be_valid
      expect(game_word.errors.added?(:word, :blank)).to be_truthy
      expect(game_word.errors.added?(:word, :taken)).not_to be_truthy
    end
  end

  context "with a non-unique word" do
    let(:game_word) { create(:game_word) }
    let(:game_word2) { build(:game_word, game: game_word.game, word: game_word.word) }

    it "should not be valid" do
      expect(game_word2).not_to be_valid
# FIXME not working for some reason
#       - see <https://github.com/rails/rails/issues/33023>
#       - and <https://github.com/rails/rails/pull/31117>
#     expect(game_word2.errors.added?(:word, :blank)).not_to be_truthy
#     expect(game_word2.errors.added?(:word, :taken)).to be_truthy
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
# FIXME not working for some reason
#       - see <https://github.com/rails/rails/issues/33023>
#       - and <https://github.com/rails/rails/pull/31117>
#     expect(game_word.errors.added?(:position, :blank)).not_to be_truthy
#     expect(game_word.errors.added?(:position, :numericality)).to be_truthy
    end
  end

  context "with a non-unique position" do
    let(:game_word) { create(:game_word) }
    let(:game_word2) { build(:game_word, game: game_word.game, position: game_word.position) }

    it "should not be valid" do
      expect(game_word2).not_to be_valid
# FIXME not working for some reason
#       - see <https://github.com/rails/rails/issues/33023>
#       - and <https://github.com/rails/rails/pull/31117>
#     expect(game_word2.errors.added?(:position, :blank)).not_to be_truthy
#     expect(game_word2.errors.added?(:position, :taken)).to be_truthy
    end
  end

  context "without a who" do
    let(:game_word) { build(:game_word, who: nil) }

    it "should not be valid" do
      expect(game_word).not_to be_valid
      expect(game_word.errors.added?(:who, :blank)).to be_truthy
      expect(game_word.errors.added?(:who, :inclusion)).not_to be_truthy
    end
  end

  context "with an invalid who" do
    let(:game_word) { build(:game_word, who: 'xyzzy') }

    it "should not be valid" do
      expect(game_word).not_to be_valid
# FIXME not working for some reason
#       - see <https://github.com/rails/rails/issues/33023>
#       - and <https://github.com/rails/rails/pull/31117>
#     expect(game_word.errors.added?(:who, :blank)).not_to be_truthy
#     expect(game_word.errors.added?(:who, :inclusion)).to be_truthy
    end
  end
end
