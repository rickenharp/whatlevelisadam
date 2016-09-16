$LOAD_PATH << File.expand_path('.')

require 'spec_helper'
require 'awesome_print'
require 'whatlevelisadam'
require 'capybara/rspec'
require 'webmock/rspec'
require 'pathname'

RSpec.configure do |config|
  include Rack::Test::Methods
  config.before(:each) do
    ENV['NO_LOGGING'] = '1'
    WebMock.disable_net_connect!(allow_localhost: true)
  end

  config.append_after(:each) do
    WebMock.allow_net_connect!
  end
end

Capybara.configure do |config|
  config.app = Whatlevelisadam.app
end

def app
  Whatlevelisadam.app
end
