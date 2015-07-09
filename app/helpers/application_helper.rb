module ApplicationHelper
  def title(page_title)
    content_for :title, page_title
    content_tag :h1, page_title
  end

  def link_to_modal(text, href, options={})
    options[:data] ||= {}
    options[:data].merge!(
     'reveal-id' => 'dialog',
     'reveal-ajax' => href
    )

    link_to text, href, options
  end

  def cache_key_for_podcasts
    count          = Podcast.count
    max_updated_at = Podcast.maximum(:updated_at).try(:utc).try(:to_s, :number)

    "podcasts/all-#{count}-#{max_updated_at}"
  end

  def cache_key_for_episodes(podcast)
    count = podcast.episodes.count
    max_updated_at = podcast.episodes.maximum(:updated_at).try(:utc).try(:to_s, :number)

    "episodes/podcast-#{podcast.id}-#{count}-#{max_updated_at}"
  end
end
