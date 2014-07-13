require 'rails_helper'

RSpec.describe Entry, type: :model do
  let(:entry) { FactoryGirl.create :entry }

  subject { entry }

  it { is_expected.to respond_to :contest }
  it { is_expected.to respond_to :skill_level }
  it { is_expected.to respond_to :hot_or_bulky? }
  it { is_expected.to respond_to :group_name }
  it { is_expected.to respond_to :categories }
  it { is_expected.to respond_to :contestants }
  it { is_expected.to respond_to :handler_count }

  describe :contest do
    subject { entry.contest }

    it { is_expected.to be_a Contest }
  end

  describe :skill_level do
    subject { entry.skill_level }

    it { is_expected.to be_a String }
    it { is_expected.to eql 'master' }
  end


  describe :hot_or_bulky? do
    subject { entry.hot_or_bulky? }

    it { is_expected.to eql false }
  end


  describe :group_name do
    subject { entry.group_name }

    it { is_expected.to be_a String }
    it { is_expected.to eql 'Trouble Makers' }
  end


  describe :categories do
    subject { entry.categories }

    it { is_expected.to be_a ActiveRecord::Associations::CollectionProxy }
  end

  describe :contestants do
    subject { entry.contestants }

    it { is_expected.to be_a ActiveRecord::Associations::CollectionProxy }
  end

  describe :handler_count do
    subject { entry.handler_count }

    it { is_expected.to be_a Integer }
    it { is_expected.to eql 2 }
  end
end
