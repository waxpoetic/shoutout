class EpisodeDecorator < Draper::Decorator
  delegate_all

  def enclosure_url
    helpers.attachment_url model, :enclosure
  end

  def image_url
    helpers.attachment_url model, :image
  end

  def content_type
    if model.is_video?
      'video/mp4'
    else
      'audio/mpeg'
    end
  end
end
