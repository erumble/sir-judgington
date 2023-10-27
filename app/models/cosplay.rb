class Cosplay < ActiveRecord::Base
  belongs_to :person, inverse_of: :cosplays
  belongs_to :character, inverse_of: :cosplays
  belongs_to :entry, inverse_of: :cosplays

  delegate :contest, to: :entry

  validates :person, :character, presence: true
  validates :person, uniqueness: { scope: :entry }
  validate :person_not_registered_in_contest

  delegate :first_name, :last_name, :full_name, :email, :nickname, to: :person, prefix: true
  delegate :name, :property, to: :character, prefix: true

  accepts_nested_attributes_for :person, :reject_if => :all_blank
  accepts_nested_attributes_for :character, :reject_if => :all_blank

  def person_not_registered_in_contest
    contest.contestants.each do |contestant|
      if (contestant == person) && (!contestant.cosplays.include? self)
        errors.add(:person, 'Already registered for this contest')
      end
    end
  end
end
