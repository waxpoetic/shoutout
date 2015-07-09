namespace :episodes do
  desc "Analyze all episode durations"
  task analyze: :environment do
    puts "Collecting all podcasts and episodes..."
    Podcast.include(:episodes).all.each do |podcast|
      puts %(Analyzing "#{podcast.title}"...)
      podcast.episodes.each do |episode|
        puts %(Updating Episode "#{episode.title}"...)
        DurationAnalyzer.update(episode)
      end
    end
  end
end
