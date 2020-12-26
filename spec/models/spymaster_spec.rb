require 'rails_helper'

RSpec.describe Spymaster, type: :model do
  subject { build(:spymaster) }
  it "should be valid" do
    expect(subject).to be_valid
  end

  context "without a sessionid" do
    let(:spymaster) { build(:spymaster, sessionid: nil) }

    it "should not be valid" do
      expect(spymaster).not_to be_valid
      expect(spymaster.errors.added?(:sessionid, :blank)).to be_truthy
    end
  end
end
