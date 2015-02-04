ENV['RACK_ENV'] = 'test'

# spec/spec_helper.rb
require 'rack/test'
require 'rspec'
require 'rspec/support/spec'
require 'database_cleaner'
require 'factory_girl'
require 'faker'

require File.expand_path '../../config/application.rb', __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app() NotificationsService end
end

FactoryGirl.find_definitions

RSpec.configure do |config|
  config.order = :random
  config.include RSpecMixin

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
    DatabaseCleaner.clean
  end

end