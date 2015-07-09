require 'duration_analyzer'

class AnalyzeEpisodeDurationJob < ActiveJob::Base
  queue_as :duration_analysis

  def perform(episode)
    if DurationAnalyzer.update(episode)
      episode.deploy_podcast
    end
  end
end
