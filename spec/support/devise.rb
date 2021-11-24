require_relative './controller_macros'
require_relative './auth'

RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, type: :controller
  #config.include Warden::Test::Helpers
  config.extend ControllerMacros, :type => :controller
  config.extend Auth
end