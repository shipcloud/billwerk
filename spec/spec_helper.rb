require "simplecov"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  SimpleCov::Formatter::HTMLFormatter,
)

SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/bundle"
  # minimum_coverage(99.15)
  refuse_coverage_drop
end

require "json"
require "pactas_itero"
require "rspec"
require "webmock/rspec"

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  # Disable should syntax
  # https://www.relishapp.com/rspec/rspec-expectations/docs/syntax-configuration
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # had to override backtrace_exclusion_patterns because of current
  # directory structure. once this gem has been extracted into a separate
  # respository this can be removed
  config.backtrace_exclusion_patterns = [
    /\/lib\d*\/ruby\//,
    /org\/jruby\//,
    /bin\//,
    /vendor\/bundle\/(.*)\/gems\//,
    /spec\/spec_helper.rb/,
    /lib\/rspec\/(core|expectations|matchers|mocks)/,
  ]

  config.after(:each) do
    PactasItero.reset!
  end
end

def fixture_path
  File.expand_path("fixtures", __dir__)
end

def fixture(file)
  File.new(fixture_path + "/" + file)
end

def pactas_api_endpoint
  PactasItero::Default::SANDBOX_API_ENDPOINT
end

def pactas_api_url(url)
  /^http/.match?(url) ? url : "#{pactas_api_endpoint}#{url}"
end

def a_delete(path)
  a_request(:delete, pactas_api_url(path))
end

def a_get(path)
  a_request(:get, pactas_api_url(path))
end

def a_post(path)
  a_request(:post, pactas_api_url(path))
end

def a_put(path)
  a_request(:put, pactas_api_url(path))
end

def stub_delete(path)
  stub_request(:delete, pactas_api_url(path))
end

def stub_get(path)
  stub_request(:get, pactas_api_url(path))
end

def stub_head(path)
  stub_request(:head, pactas_api_url(path))
end

def stub_post(path)
  stub_request(:post, pactas_api_url(path))
end

def stub_put(path)
  stub_request(:put, pactas_api_url(path))
end

def stub_patch(path)
  stub_request(:patch, pactas_api_url(path))
end
