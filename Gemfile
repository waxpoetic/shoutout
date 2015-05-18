source 'https://rubygems.org'
#source 'https://rails-assets.org'

gem 'rails', '~> 4.2'
gem 'pg'
gem 'active_model_serializers'
gem 'puma'
gem 'sidekiq'
gem 'draper'
gem 'simple_form'
gem 'controller_resources'
gem 'sass-rails'
gem 'coffee-rails'
gem 'foundation-rails'
gem 'uglifier',         '~> 1.3'
gem 'jquery-rails'
gem 'autoprefixer-rails'
gem 'refile', require: 'refile/rails'
gem 'devise'
gem 'pundit'
gem 'haml-rails'
gem 'aws-sdk'
gem 'refile-s3', github: 'refile/refile-s3'

group :development do
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console', '~> 2.0'
  gem 'annotate'
end

group :development, :test do
  gem 'pry-rails'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
end

group :production do
  gem 'rack-cache'
  gem 'redis-rails'
  gem 'asset_sync'
end
