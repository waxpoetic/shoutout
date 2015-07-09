require 'mediainfo'

# Analyzes the duration for a given media file. Also has the ability to
# update the media file's corresponding Episode with its new duration.
class DurationAnalyzer
  # The file that is being analyzed.
  #
  # @type [Refile::Attachment]
  attr_reader :file

  # Instantiate a new analyzer with a given enclosure file.
  #
  # @param [Refile::Attachment] media_file
  def initialize(media_file)
    @file = media_file
  end

  # Analyze the episode's enclosure and update its attributes.
  #
  # @returns true if the update succeeded
  def self.update(episode)
    analyzer = new(episode.enclosure)
    episode.update_attributes duration: analyzer.duration
  end

  # The duration of the given media file.
  #
  # @returns [String]
  def duration
    if media.video?
      media.video.duration
    else
      media.audio.duration
    end
  end

  # Full Mediainfo analysis of the file at its given path on disk.
  #
  # @returns [Mediainfo]
  def media
    @media ||= Mediainfo.new(file.path)
  end
end
