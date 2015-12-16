class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

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

end
