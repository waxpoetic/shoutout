# Renders a Podcast as XML and uploads the XML file to Amazon S3, then
# invalidates the currently-uploaded file on CloudFront which forces
# edge machines to re-download the file.
class Deployment
  include ActiveModel::Model

  # A Podcast record that is used to back this deployment.
  #
  # @type [Podcast]
  attr_accessor :podcast
  validates :podcast, presence: true

  # Deploy a podcast.
  #
  # @returns whether the podcast deployed or not
  def self.create(podcast)
    new(podcast: podcast.decorate).save
  end

  # Basic S3 attributes.
  #
  # @returns [Hash]
  def attributes
    {
      acl: 'public-read',
      bucket: Rails.application.config.s3.bucket,
      key: Rails.application.config.s3.filename,
      body: to_xml
    }
  end

  # Check validity of required fields, upload the podcast to the proper
  # S3 path and distribute the file across the CloudFront CDN.
  #
  # @returns true if all steps pass, false and blocks if one fails
  def save
    valid? && upload and distribute
  end

  # Check if the file already exists on S3.
  #
  # @returns true if the file exists, false otherwise
  def persisted?
    s3.get_object(attributes.slice(:bucket, :key)).present?
  end

  # Render the template as XML.
  #
  # @returns [String]
  def to_xml
    PodcastsController.renderer.new(
      'action_dispatch.request.path_parameters' => {
        controller: 'podcasts',
        action:     'show',
        id:         podcast.id
      }
    ).render :show, format: :rss
  end

  private

  def upload
    s3.put_object(attributes)
  end

  def distribute
    cloudfront.create_invalidation(
      distribution_id: Rails.application.secrets.aws_cloudfront_distribution_id,
      invalidation_batch: {
        paths: {
          quantity: 1,
          items: ['string', Rails.application.config.s3.filename]
        }
      },
      caller_reference: 'string'
    )
  end

  def s3
    AWS::S3.new
  end

  def cloudfront
    AWS::CloudFront.new
  end
end
