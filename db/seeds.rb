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
  short_url2 = ShortenedUrl.create_for_user_and_long_url!(will, "apple.com")
  short_url3 = ShortenedUrl.create_for_user_and_long_url!(frankie, "yahoo.com")
  short_url4 = ShortenedUrl.create_for_user_and_long_url!(frankie, "bing.com")
  short_url5 = ShortenedUrl.create_for_user_and_long_url!(frankie, "appacademy.io")
  short_url6 = ShortenedUrl.create_for_user_and_long_url!(frankie, "amazon.com")
  short_url7 = ShortenedUrl.create_for_user_and_long_url!(frankie, "netflix.com")
  # short_url4 = ShortenedUrl.create_for_user_and_long_url!(will, "apple.com")

  Visit.destroy_all
  visit1 = Visit.record_visit!(will, short_url)
  visit2 = Visit.record_visit!(frankie, short_url2)
  visit4 = Visit.record_visit!(frankie, short_url)
  visit5 = Visit.record_visit!(frankie, short_url)
  visit3 = Visit.record_visit!(will, short_url3)

  TagTopic.destroy_all
  tag1 = TagTopic.create!(topic: "birds")
  tag2 = TagTopic.create!(topic: "flowers")
  tag3 = TagTopic.create!(topic: "ruby")

  Tagging.destroy_all
  tagging1 = Tagging.create!(tag_topic_id: tag1.id, url_id: short_url.id)
  tagging2 = Tagging.create!(tag_topic_id: tag2.id, url_id: short_url2.id)
  tagging3 = Tagging.create!(tag_topic_id: tag3.id, url_id: short_url3.id)
  tagging4 = Tagging.create!(tag_topic_id: tag3.id, url_id: short_url2.id)
  tagging5 = Tagging.create!(tag_topic_id: tag3.id, url_id: short_url.id)
