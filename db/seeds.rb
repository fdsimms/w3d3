# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  User.destroy_all
  will = User.create!(email: "will@will.com")
  frankie = User.create!(email: "frankie@frankie.com")

  ShortenedUrl.destroy_all
  short_url = ShortenedUrl.create_for_user_and_long_url!(will, "google.com")
  short_url2 = ShortenedUrl.create_for_user_and_long_url!(frankie, "apple.com")
  short_url3 = ShortenedUrl.create_for_user_and_long_url!(frankie, "yahoo.com")
  # short_url4 = ShortenedUrl.create_for_user_and_long_url!(will, "apple.com")

  Visit.destroy_all
  visit1 = Visit.record_visit!(will, short_url)
  visit2 = Visit.record_visit!(frankie, short_url2)
  visit4 = Visit.record_visit!(frankie, short_url)
  visit5 = Visit.record_visit!(frankie, short_url)
  visit3 = Visit.record_visit!(will, short_url3)
