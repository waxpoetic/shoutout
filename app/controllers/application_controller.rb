require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder

  protect_from_forgery with: :exception

  before_action :authenticate_user!
  after_action  :populate_flash_headers

  respond_to :html

  private

  def populate_flash_headers
    headers['Flash'] = flash.reduce([]) do |msgs, (type, message)|
      msgs << { type: type, text: message }
      msgs
    end
  end
end
