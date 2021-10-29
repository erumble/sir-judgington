# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html

# Create the static categories
categories = %w(anime manga video_game other_media)
categories.each do |category|
  Category.where(name: category, common: true).first_or_create
end
puts "CREATED CATEGORIES: #{categories.join(', ').humanize.titleize}"

# Create the static judging times
judging_times = %w(
  Fri-1:00  Fri-1:15  Fri-1:30  Fri-1:45
  Fri-2:00  Fri-2:15  Fri-2:30  Fri-2:45
  Fri-3:00  Fri-3:15  Fri-3:30  Fri-3:45
  Fri-4:00  Fri-4:15  Fri-4:30  Fri-4:45
  Sat-10:00 Sat-10:15 Sat-10:30 Sat-10:45
  Sat-11:00 Sat-11:15 Sat-11:30 Sat-11:45
  Sat-12:00 Sat-12:15 Sat-12:30 Sat-12:45
  Sat-1:00  Sat-1:15  Sat-1:30  Sat-1:45
)
judging_times.each do |time|
  JudgingTime.where(time: time, common: true).first_or_create
end
puts "CREATED JUDGING TIMES: #{judging_times.join(', ').humanize}"
