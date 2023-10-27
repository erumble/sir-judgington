class Person < ActiveRecord::Base
  has_many :cosplays, inverse_of: :person
  has_many :characters, through: :cosplays
  has_many :entries, through: :cosplays

  validates :email, uniqueness: true
  validates :email, :first_name, :last_name, presence: true

  def full_name
    fn = "#{first_name} #{last_name}"
    nickname.empty? ? fn : "#{nickname} (#{fn})"
    # "#{first_name} #{last_name}"
  end
end
