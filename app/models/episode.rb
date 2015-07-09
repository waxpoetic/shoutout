class Episode < ActiveRecord::Base
  belongs_to :podcast

  attachment :image
  attachment :enclosure, content_type: %w(
    audio/mpeg video/mp4
  )

  before_validation :use_podcast_defaults

  validates :podcast,       presence: true
  validates :title,         presence: true
  validates :author,        presence: true
  validates :subtitle,      presence: true
  validates :summary,       presence: true
  validates :image,         presence: true
  validates :enclosure,     presence: true
  validates :published_at,  presence: true

  after_create :analyze_duration

  scope :with_video, -> { where is_video: true }
  scope :in_sequence, -> { order :published_at }

  after_commit :deploy_podcast

  def categories
    read_attribute(:categories) || []
  end

  private

  def deploy_podcast
    podcast.deploy
  end

  def use_podcast_defaults
    self.image ||= podcast.image
    self.author ||= podcast.author
    self.published_at ||= DateTime.now
  end

  def analyze_duration
    AnalyzeEpisodeDurationJob.perform_later(self)
  end
end

# == Schema Information
#
# Table name: episodes
#
#  id           :integer          not null, primary key
#  podcast_id   :integer
#  title        :string
#  author       :string
#  subtitle     :string
#  summary      :string
#  image_id     :string
#  enclosure_id :string
#  published_at :datetime
#  duration     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  is_video     :boolean          default(FALSE)
#
# Indexes
#
#  index_episodes_on_podcast_id  (podcast_id)
#
