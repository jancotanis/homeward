require File.expand_path('api', __dir__)
require File.expand_path('error', __dir__)

module HomeWizard
  # Wrapper for the HomeWizard REST API
  #
  # @see https://api-documentation.homewizard.com/docs/introduction/
  class Client < API
    attr_reader :device_info
    # get client to access P1 meter
    # @return [P1Client]
    def initialize(options = {})
      # create client and copy access_token and set default headers
      super(options)
      @device_info = product_info
      puts "* probably incompatible api version" unless 'v1'.eql? product_info.api_version
    rescue Faraday::ForbiddenError => e
      raise APInotEnabledError.new e.response[:body]['error']
    end
    # return api path
    def self.url(method)
      path = method ? "v1/#{method}" : ''
      "/api/#{path}"
    end


  private
    def self.api_endpoint(method, path = nil, valid_devices = nil)

      _url = self.url(path)
      # all records
      self.send(:define_method, method) do |params = {}|
        if valid_devices && !valid_devices.include?(@device_info.product_type)
          raise DeviceTypeError.new "Method #{method} not available for this device #{@device_info.product_name}"
        end
        r = get(_url, params)
      end
    end

  public
    # return device information
    # product_type
    # product_name
    # serial
    # firmware_version
    # api_version
    # devices: HWE-P1, HWE-SKT,	HWE-WTR, HWE-KWH1 and SDM230-wifi,	HWE-KWH3 and SDM630-wifi
    api_endpoint :product_info
    # devices: HWE-P1, HWE-SKT,	HWE-WTR, HWE-KWH1 and SDM230-wifi,	HWE-KWH3 and SDM630-wifi
    api_endpoint :recent_measurement, 'data', ['HWE-P1', 'HWE-SKT']
    api_endpoint :socket_state, 'state', ['HWE-SKT']
    api_endpoint :telegram, 'telegram', ['HWE-P1']
    api_endpoint :identify, 'identify', ['HWE-P1', 'HWE-SKT']

  end
end
