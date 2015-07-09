require 'rails_helper'

RSpec.describe Podcast, type: :model do
  subject do
    Podcast.new(
      title: 'brother.ly video',
      link: 'http://brother.ly',
      language: 'en-us',
      copyright: '&copy; 2015 Wax Poetic Records',
      subtitle: 'Video transmissions',
      author: 'brother.ly impresarios',
      description: 'All video recordings of brother.ly events',
      email: 'events@thewonderbars.com',
      image_id: 'podcast.png',
      categories: ['Music']
    )
  end

  it 'validates all attributes' do
    expect(subject).to be_valid
  end

  it 'can be deployed' do
    allow(DeployPodcastJob).to receive(:perform_later).and_return(false)
    allow(DeployPodcastJob).to receive(:perform_later).with(subject).and_return(true)
    expect(subject.deploy).to eq(true)
  end

  it 'is video when any episodes have video' do
    podcast = podcasts :video
    expect(podcast).to be_is_video
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
