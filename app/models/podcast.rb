class Podcast < ActiveRecord::Base
  has_many :episodes, dependent: :destroy, inverse_of: :podcast

  attachment :image

  validates :title,       presence: true
  validates :link,        presence: true
  validates :language,    presence: true
  validates :copyright,   presence: true
  validates :subtitle,    presence: true
  validates :author,      presence: true
  validates :description, presence: true
  validates :email,       presence: true
  validates :image,       presence: true
  validates :categories,  presence: true

  after_commit :deploy

  def is_video?
    episodes.with_video.any?
  end

  def deploy
    DeployPodcastJob.perform_later self
  end
end

# == Schema Information
#
# Table name: podcasts
#
#  id          :integer          not null, primary key
#  title       :string
#  link        :string
#  language    :string           default("en-us")
#  copyright   :string
#  subtitle    :string
#  author      :string
#  description :string
#  email       :string
#  image_id    :string
#  categories  :string           is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
