# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :entry do
    skill_level 4
    hot_or_bulky false
    group_name 'Trouble Makers'
    handler_count 2
    contest
  end
end
