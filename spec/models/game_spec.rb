require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { build(:game) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "without a sessionid" do
    let(:game) { build(:game, sessionid: nil) }

    it "should not be valid" do
      expect(game).not_to be_valid
      expect(game.errors.added?(:sessionid, :blank)).to be_truthy
    end
  end

  context "without a name" do
    let(:game) { build(:game, name: nil) }

    it "should not be valid" do
      expect(game).not_to be_valid
      expect(game.errors.added?(:name, :blank)).to be_truthy
    end
  end

  context "with a non-unique name" do
    let(:game) { create(:game) }
    let(:game2) { build(:game, name: game.name) }

    it "should not be valid" do
      expect(game2).not_to be_valid
# FIXME not working for some reason
#       - see <https://github.com/rails/rails/issues/33023>
#       - and <https://github.com/rails/rails/pull/31117>
#     expect(game2.errors.added?(:name, :taken)).to be_truthy
    end
  end
end
