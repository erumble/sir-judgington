require 'rails_helper'

RSpec.describe Character, :type => :model do
  let(:character) { FactoryGirl.create :character }

  subject { character }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :property }
  it { is_expected.to respond_to :cosplays }
  it { is_expected.to respond_to :people }
  it { is_expected.to respond_to :entries }
  # it { is_expected.to respond_to :owner }
  # it { is_expected.to respond_to :creators}

  describe :character_name do
    subject { character.name }

    it { is_expected.to be_a String }
    it { is_expected.to eql 'Tyrol Ericson' }
  end

  describe :property do
    subject { character.property }

    it { is_expected.to be_a String }
    it { is_expected.to eql 'I made it up' }
  end

  describe :cosplays do
    subject { character.cosplays }

    it { is_expected.to be_a ActiveRecord::Associations::CollectionProxy }
  end

  describe :people do
    subject { character.people }

    it { is_expected.to be_a ActiveRecord::Associations::CollectionProxy }
  end

  describe :entries do
    subject { character.entries }

    it { is_expected.to be_a ActiveRecord::Associations::CollectionProxy }
  end

  # describe :owner do
  #   subject { character.owner }
  #
  #   it { is_expected.to be_a Contestant }
  # end

  # describe :creators do
  #   subject { character.creators }
  #
  #   it { is_expected.to be_a ActiveRecord::Associations::CollectionProxy }
  # end
end
