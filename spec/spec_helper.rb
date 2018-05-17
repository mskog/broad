ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec-given'
require 'database_cleaner'
require 'webmock/rspec'

require 'webdrivers' unless ENV.key?('CIRCLECI')

WebMock.enable!

# save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLECI']
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

allowed_hosts = [/codeclimate\.com/, /storage.googleapis.com/]
WebMock.disable_net_connect!(allow_localhost: true, allow: allowed_hosts)

load File.join(Rails.root, 'Rakefile')

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

require "selenium/webdriver"

RSpec.configure do
  Capybara.server = :puma
  Capybara.server_port = 5000

  Capybara.register_driver(:chrome) do |app|
    chrome_args = %w[window-size=1600,768]
    chrome_args += %w[headless disable-gpu] unless ENV['TEST_CARTOON']

    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: chrome_args }
      )

      Capybara::Selenium::Driver.new(
        app,
        browser: :chrome,
        desired_capabilities: capabilities
        )
      end

      Capybara.javascript_driver = :chrome
    end


    RSpec.configure do |config|
      # Ensure that if we are running js tests, we are using latest webpack assets
      # This will use the defaults of :js and :server_rendering meta tags
      ReactOnRails::TestHelper.configure_rspec_to_compile_assets(config)

      config.run_all_when_everything_filtered = true
      config.filter_run :focus
      config.infer_spec_type_from_file_location!

      config.order = 'random'

      config.include FactoryBot::Syntax::Methods

      config.expect_with :rspec do |c|
        c.syntax = [:expect]
      end


      config.before(:each) do
        DatabaseCleaner.strategy = :transaction
      end

      config.before(:each, type: :feature) do
        driver_shares_db_connection_with_specs = Capybara.current_driver == :rack_test

        unless driver_shares_db_connection_with_specs
          DatabaseCleaner.strategy = :truncation
        end
      end

      config.before(:each) do
        DatabaseCleaner.start
      end

      config.append_after(:each) do
        DatabaseCleaner.clean
      end

      config.before(:all) do
        FactoryBot.reload
      end

      # Fakes
      config.before :each do
        stub_request(:any, /passthepopcorn.me/).to_rack(FakePTP)
        stub_request(:any, /api.themoviedb.org/).to_rack(FakeTmdb)
        stub_request(:any, /trakt.tv/).to_rack(FakeTrakt)
        stub_request(:any, /spoiled.mskog.com/).to_rack(FakeSpoiled)
      end
    end
