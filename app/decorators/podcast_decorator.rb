class PodcastDecorator < Draper::Decorator
  delegate_all

  def image_url
    helpers.attachment_url model, :image
  end

  def episodes
    model.episodes.in_sequence.map(&:decorate)
  end
end
