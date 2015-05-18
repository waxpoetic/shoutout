class PodcastDecorator < Draper::Decorator
  delegate_all

  def image_url
    helpers.attachment_url model, :image
  end
end
