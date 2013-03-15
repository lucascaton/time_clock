require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
# require 'capybara/rspec'
# require 'capybara/rails'
# require 'capybara/poltergeist'

Rails.logger.level = 4 # reduce the IO during tests

# Requires supporting ruby files with custom matchers
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Requires supporting ruby files with macros
Dir[Rails.root.join('spec/features/macros/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = 'random'
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # config.include AcceptanceMacros, type: :feature
  config.include FactoryGirl::Syntax::Methods
end

# Capybara.configure do |config|
#   config.javascript_driver      = :poltergeist
#   config.ignore_hidden_elements = true
#   config.default_selector       = :css
#   config.default_wait_time      = 10
# end
