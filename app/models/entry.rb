class Entry < ActiveRecord::Base
  enum skill_level: { exhibition: 0,
                      youth:      1,
                      novice:     2,
                      journeyman: 3,
                      master:     4 }

  has_and_belongs_to_many :categories, -> { readonly }
  has_and_belongs_to_many :contestants
  belongs_to :contest
  validates :contest, presence: true
end
