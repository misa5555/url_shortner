class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  belongs_to(
   :submitter,
   class_name: 'User',
   foreign_key: :submitter_id,
   primary_key: :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor,
  )

  has_many(
    :visits,
    class_name: 'Visit',
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  def self.random_code
    short = nil
    loop do
      short = SecureRandom.urlsafe_base64
      unless ShortenedUrl.exists?(short_url: short)
        return short
      end
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.create!( long_url: long_url, short_url: self.random_code,
    submitter_id: user.id)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    # visits
    self.visits.select(:user_id).where("created_at > ?", 30.minutes.ago).distinct.count
    #visitors.where("visits. > ?", 0).count
  end
end
