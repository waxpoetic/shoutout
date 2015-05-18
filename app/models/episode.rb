class Episode < ActiveRecord::Base
  belongs_to :podcast

  attachment :image
  attachment :enclosure

  validates :podcast,       presence: true
  validates :title,         presence: true
  validates :author,        presence: true
  validates :subtitle,      presence: true
  validates :summary,       presence: true
  validates :image,         presence: true
  validates :enclosure,     presence: true
  validates :published_at,  presence: true
  validates :duration,      presence: true
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
#
# Indexes
#
#  index_episodes_on_podcast_id  (podcast_id)
#
