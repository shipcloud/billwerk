# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pactas_itero/version'

Gem::Specification.new do |spec|
  spec.name          = 'pactas_itero'
  spec.version       = PactasItero::VERSION
  spec.authors       = ['Simon Fröhler']
  spec.email         = "simon@shipcloud.io"
  spec.summary       = %q{pactas_itero provides a client mapping for accessing
    the Pactas Itero API.}
  spec.description   = %q{pactas_itero provides a client mapping for accessing
    the Pactas Itero API, making it easy to post your data to, adn read your
    data from your Pactas account.}
  spec.homepage      = 'https://github.com/webionate/pactas_itero'
  spec.license       = 'MIT'

  spec.files = Dir["lib/**/*.rb"] + Dir["bin/*"]
  spec.files += Dir["[A-Z]*"] + Dir["spec/**/*"]
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.executables   = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = ">= 2.0"

  spec.add_dependency("faraday_middleware", ">= 1.0")
  spec.add_dependency("rash_alt")

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency "rspec", '~> 3.8.0'
  spec.add_development_dependency("rubocop", '~> 1.17') # check houndci compatibility before updating rubocop
  spec.add_development_dependency("rubocop-performance", "~> 1.3")
  spec.add_development_dependency("simplecov", "~> 0.16.1")
  spec.add_development_dependency("webmock", "~> 3.3")
end
