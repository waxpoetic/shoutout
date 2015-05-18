require File.expand_path('../boot', __FILE__)

require "rails"

%w(
  active_record
  action_controller
  action_view
  action_mailer
  active_job
  sprockets
).each do |framework|
  begin
    require "#{framework}/railtie"
  rescue LoadError
  end
end

# Require the gems listed in Gemfile
Bundler.require :default, Rails.env

module Shoutout
  class Application < Rails::Application
    # Use EST as our local time zone. (UTC is default)
    #config.time_zone = 'Eastern Time (US & Canada)'

    # Raise errors during transactional callback methods. This will be
    # the default in upcoming versions of Rails.
    config.active_record.raise_in_transactional_callbacks = true

    # Always show debug logs, because we filter them out in syslog.
    config.log_level = :debug

    # Use localhost as mail server (for Devise)
    #config.action_mailer.default_url_options = { host: 'localhost:3000' }
    #
    config.s3 = ActiveSupport::OrderedOptions.new
    config.s3.bucket = 'brother.ly'
    config.s3.filename = 'podcast.xml'
  end
end
