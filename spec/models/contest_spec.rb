require 'rails_helper'

RSpec.describe Contest, :type => :model do
  let(:contest) { FactoryGirl.create :contest }

  subject { contest }

  it { is_expected.to respond_to :date }
  it { is_expected.to respond_to :entries }

  describe :date do
    subject { contest.date }

    it { is_expected.to be_a Date }
    it { is_expected.to eql Date.parse '27-09-2014' }
  end

  describe :entries do
    subject { contest.entries }

    it { is_expected.to be_a ActiveRecord::Associations::CollectionProxy }
  end
end
