require 'aws/s3'

class DeployPodcastJob < ActiveJob::Base
  queue_as :deployment

  def perform(podcast)
    response = Net::HTTP.get_response(URI.parse("#{config.domain}/podcasts/#{podcast.id}.rss"))

    if response.is_a? Net::HTTPSuccess
      s3.put_object(
        acl: 'public-read',
        bucket: config.s3.bucket,
        key: config.s3.filename,
        body: response.body
      )
    else
      logger.error 'Failed to find podcast XML'
    end
  end

  private

  def s3
    AWS::S3.new
  end
end
