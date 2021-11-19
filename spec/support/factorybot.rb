# help from https://www.youtube.com/watch?v=ef82mR9Mm8Q and Kevyn Kelso

require_relative './auth'
require_relative './controller_macros'

RSpec.configure do |config|
    config.include FactoryBot::Syntax::Methods
    config.include Devise::Test::ControllerHelpers, type: :controller
    config.extend ControllerMacros, type: :controller
    config.extend Auth
end