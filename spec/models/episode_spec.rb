require 'rails_helper'

RSpec.describe Episode, type: :model do
  subject do
    Episode.new(
      title: 'Episode One',
      author: 'brother.ly',
      subtitle: 'Michael NightTime, The Wonder Bars, Mambisa, Highly Desirable',
      summary: 'We rock the party that rocks the party.',
      image_id: 'cover.png',
      enclosure_id: 'music.mp3',
      published_at: DateTime.now,
      duration: '01:04:20'
    )
  end

  it 'validates all attributes' do
    expect(episode).to be_valid
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
#
# Indexes
#
#  index_episodes_on_podcast_id  (podcast_id)
#
