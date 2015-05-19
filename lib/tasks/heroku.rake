namespace :heroku do
  desc "Generate Heroku configuration"
  task config: :environment do
    settings = File.open("#{Rails.root}/.env").split("\n").reject do |line|
      line =~ /PATH|HEROKU/
    end.join("\s")

    sh "heroku config:set #{settings}"
  end
end
