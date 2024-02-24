module HomeWizard

  # Generic error to be able to rescue all Hudu errors
  class HomeWizardError < StandardError; end

  # Wrong api for given device
  class APInotEnabledError < HomeWizardError; end

  # Wrong api for given device
  class DeviceTypeError < HomeWizardError; end
end
