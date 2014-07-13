class Costume < ActiveRecord::Base
  belongs_to :owner, class_name: 'Contestant'
  has_and_belongs_to_many :creators, class_name: 'Contestant'
  validates :owner, presence: true
end
