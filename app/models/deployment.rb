require 'aws/s3'
require 'aws/cloudfront'
require 'erb'

# Renders a Podcast as XML and uploads the XML file to Amazon S3, then
# invalidates the currently-uploaded file on CloudFront which forces
# edge machines to re-download the file.
class Deployment
  include ActiveModel::Model

  attr_accessor :podcast

  validates :file, presence: { message: 'not found' }
  validates :template, presence: { message: 'could not be parsed' }

  def self.create(podcast)
    new(podcast: podcast).save
  end

  def attributes
    {
      acl: 'public-read',
      bucket: Rails.application.config.s3.bucket,
      key: Rails.application.config.s3.filename,
      body: to_xml
    }
  end

  def save
    valid? && upload && invalidate
  end

  def persisted?
    s3.get_object(attributes.slice(:bucket, :key))
  end

  def to_xml
    template.result(binding)
  end

  private

  def upload
    s3.put_object(attributes)
  end

  def invalidate
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

  def template
    ERB.new file
  rescue StandardError
    nil
  end

  def file
    File.read "#{Rails.root}/lib/templates/podcast.xml.erb"
  rescue StandardError
    nil
  end

  def s3
    AWS::S3.new
  end

  def cloudfront
    AWS::CloudFront.new
  end
end
