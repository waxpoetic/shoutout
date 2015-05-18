# Deploys a Podcast to Amazon S3 in the background.
class DeployPodcastJob < ActiveJob::Base
  queue_as :deployment

  def perform(podcast)
    Deployment.create(podcast)
  end
end
