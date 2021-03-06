require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { build(:game) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "without a name" do
    let(:game) { build(:game, name: "") }

    it "should not be valid" do
      expect(game.save).to be_falsey
      expect(game.errors.added?(:name, :blank)).to be_truthy
      expect(game.errors.added?(:name, :taken, value: "")).not_to be_truthy
    end
  end

  context "with a non-unique name" do
    let(:game) { create(:game) }
    let(:game2) { build(:game, name: game.name) }

    it "should not be valid" do
      expect(game2.save).to be_falsey
      expect(game2.errors.added?(:name, :blank)).not_to be_truthy
      expect(game2.errors.added?(:name, :taken, value: game.name)).to be_truthy
    end
  end

  describe "#next_position" do
    context "with a game with no words" do
      let(:game) { create(:game) }

      it "should return 0" do
        expect(game.next_position).to be == 0
      end
    end

    context "with a game with some words" do
      let(:game) { create(:game, game_words: build_list(:game_word, 3)) }

      it "should return the next position" do
        expect(game.next_position).to be == 3
      end
    end

    context "with a game with all words" do
      let(:game) { create(:game, game_words: build_list(:game_word, Game::N_WORDS)) }

      it "should return nil" do
        expect(game.next_position).to be == nil
      end
    end
  end
end
