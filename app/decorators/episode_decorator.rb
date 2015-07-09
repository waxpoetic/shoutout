class EpisodeDecorator < Draper::Decorator
  delegate_all

  def download_url
    helpers.attachment_url model, :enclosure
  end

  def image_url
    helpers.attachment_url model, :image
  end
end
