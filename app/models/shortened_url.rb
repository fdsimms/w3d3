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
end
