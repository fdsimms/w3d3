class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :long_url, length: { maximum: 1024 }
  validates :submitter, presence: true
  validate :user_cannot_submit_more_than_five_urls_per_minute
  validate :non_premium_user_cannot_create_more_than_five_urls

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor
  )

  has_many(
    :taggings,
    class_name: "Tagging",
    foreign_key: :url_id,
    primary_key: :id
  )

  has_many(
    :tag_topics,
    through: :taggings,
    source: :tag_topic
  )

  def self.random_code
    random_code = SecureRandom.urlsafe_base64[0...16]
    if ShortenedUrl.exists?(short_url: random_code)
      self.random_code
    else
      random_code
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    short_url = self.random_code
    ShortenedUrl.create!(short_url: short_url, submitter_id: user.id, long_url: long_url)
  end

  def self.prune
    # ShortenedUrl.destroy_all(['created_at < (?)', 1.minutes.ago])
    urls_and_users = ShortenedUrl.joins('INNER JOIN users ON shortened_urls.submitter_id = users.id')

    urls_and_users
      .where('shortened_urls.created_at < (?) AND users.premium = (?)', 1.minutes.ago, 'f')
      .destroy_all
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    time_range = (10.minutes.ago..Time.now)
    visitors.where('created_at' => time_range).count
  end

  private
    def user_cannot_submit_more_than_five_urls_per_minute
      submitted_urls = User.find(self.submitter_id).submitted_urls
      time_range = (1.minute.ago..Time.now)
      recent_subs = submitted_urls.where('created_at' => time_range).count

      if recent_subs >= 5
        errors[:base] << "can't submit more than five urls per minute"
      end
    end

    def non_premium_user_cannot_create_more_than_five_urls
      user = User.find(self.submitter_id)
      submitted_urls_count = user.submitted_urls.count

      if submitted_urls_count >= 5 && !user.premium
        errors[:base] << "non-premium users can't submit more than 5 urls"
      end
    end
end
