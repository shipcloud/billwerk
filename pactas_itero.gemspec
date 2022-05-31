# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pactas_itero/version"

# rubocop:disable Metrics/BlockLength
Gem::Specification.new do |spec|
  spec.name          = "pactas_itero"
  spec.version       = PactasItero::VERSION
  spec.authors       = ["Simon Fröhler"]
  spec.email         = "simon@shipcloud.io"
  spec.summary       = 'pactas_itero provides a client mapping for accessing
    the Pactas Itero API.'
  spec.description   = 'pactas_itero provides a client mapping for accessing
    the Pactas Itero API, making it easy to post your data to, and read your
    data from your Pactas account.'
  spec.homepage      = "https://github.com/webionate/pactas_itero"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci))})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.6"

  spec.add_dependency("faraday_middleware", ">= 1.0")
  spec.add_dependency("rash_alt")

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.11.0"
  spec.add_development_dependency("rubocop", "~> 1.25.1")
  spec.add_development_dependency("rubocop-performance", "~> 1.14.0")
  spec.add_development_dependency("rubocop-rake")
  spec.add_development_dependency("rubocop-rspec")
  spec.add_development_dependency("simplecov", "~> 0.16.1")
  spec.add_development_dependency("webmock", "~> 3.3")
  spec.metadata["rubygems_mfa_required"] = "true"
end
# rubocop:enable Metrics/BlockLength
