require "wrapi"
#require File.expand_path('authentication', __dir__)
#require File.expand_path('configuration', __dir__)

module HomeWizard
  # @private
  class API

    # @private
    attr_accessor *WrAPI::Configuration::VALID_OPTIONS_KEYS

    # Creates a new API and copies settings from singleton
    def initialize(options = {})
      options = HomeWizard.options.merge(options)
      WrAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def config
      conf = {}
      WrAPI::Configuration::VALID_OPTIONS_KEYS.each do |key|
        conf[key] = send key
      end
      conf
    end

#    include Configuration
    include WrAPI::Connection
    include WrAPI::Request
#    include WrAPI::Authentication
#    include Authentication
  end
end
