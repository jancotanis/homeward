require "wrapi"
require File.expand_path('homewizard/client', __dir__)

module HomeWizard
  extend WrAPI::Configuration
  extend WrAPI::RespondTo

  DEFAULT_UA = 'Ruby HomeWizard API client'
  #
  # @return [Hudu::Client]
  def self.client(options = {})
    HomeWizard::Client.new({ user_agent: DEFAULT_UA }.merge(options))
  end

  def self.reset
    super
    self.endpoint = nil
    self.user_agent = DEFAULT_UA
  end
end
