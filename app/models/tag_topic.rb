class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :tag_topic_id,
    primary_key: :id
  )

  has_many(
    :urls,
    through: :taggings,
    source: :shortened_url
  )


end
