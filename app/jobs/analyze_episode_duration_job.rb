require 'duration_analyzer'

class AnalyzeEpisodeDurationJob < ActiveJob::Base
  queue_as :duration_analysis

  def perform(episode)
    DurationAnalyzer.update(episode)
  end
end
