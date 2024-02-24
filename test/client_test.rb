require 'dotenv'
require 'logger'
require 'test_helper'

CLIENT_LOGGER = 'client_test.log'
File.delete(CLIENT_LOGGER) if File.exist?(CLIENT_LOGGER)

describe 'client' do
  before do
    HomeWizard.reset
  end

  it '#1 GET api info' do
    HomeWizard.configure do |config|
      config.endpoint = ENV['HOMEWIZARD_ENERGY_METER'].downcase
      config.logger = Logger.new(CLIENT_LOGGER)
    end
    assert_raises HomeWizard::APInotEnabledError do
      client = HomeWizard.client
      flunk "Should have raised API not anabled error"
    end
  end

  it '#2 GET p1 measurement' do
    HomeWizard.configure do |config|
      config.endpoint = ENV['HOMEWIZARD_P1_API_HOST'].downcase
      config.logger = Logger.new(CLIENT_LOGGER)
    end
    client = HomeWizard.client
    data = client.recent_measurement
    assert data.active_power_w != 0
  end

  it '#3 GET p1 state ' do
    HomeWizard.configure do |config|
      config.endpoint = ENV['HOMEWIZARD_P1_API_HOST'].downcase
      config.logger = Logger.new(CLIENT_LOGGER)
    end
    client = HomeWizard.client
    assert_raises HomeWizard::DeviceTypeError do
      data = client.socket_state
      flunk "Mehtod should raise HomeWizard::DeviceTypeError"
    end
  end
  it '#4 GET p1 telegram ' do
    HomeWizard.configure do |config|
      config.endpoint = ENV['HOMEWIZARD_P1_API_HOST'].downcase
      config.logger = Logger.new(CLIENT_LOGGER)
    end
    client = HomeWizard.client
    data = client.telegram
    puts data.inspect
  end

end
