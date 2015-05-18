require 'rails_helper'

RSpec.describe Episode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
