require 'rails_helper'

class Deployment
  RSpec.describe Template, type: :model do
    let :podcast do
      podcasts :brotherly_audio
    end

    let :deployment do
      Deployment.new podcast: podcast.decorate
    end

    subject do
      Template.new deployment
    end

    it 'renders to xml' do
      expect(subject.to_xml).to include(episode.title)
    end
  end
end
