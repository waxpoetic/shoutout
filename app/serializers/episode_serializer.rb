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

class EpisodeSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :subtitle, :summary, :image, :enclosure_id, :published_at, :duration
  has_one :podcast
end
