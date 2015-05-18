# Renders a Podcast as XML and uploads the XML file to Amazon S3, then
# invalidates the currently-uploaded file on CloudFront which forces
# edge machines to re-download the file.
class Deployment
  include ActiveModel::Model

  attr_accessor :podcast

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
    s3.put_object(attributes)
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

  def persisted?
    s3.get_object(attributes.slice(:bucket, :key))
  end

  def to_xml
    template.result(binding)
  end

  private

  def template
    ERB.new source
  end

  def source
    File.read "#{Rails.root}/lib/templates/podcast.xml.erb"
  end

  def s3
    AWS::S3.new
  end
end
