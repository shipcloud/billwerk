# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pactas_itero/version'

Gem::Specification.new do |spec|
  spec.name          = 'pactas_itero'
  spec.version       = PactasItero::VERSION
  spec.authors       = ['Simon Fröhler']
  spec.email         = 'simon@webionate.de'
  spec.summary       = %q{pactas_itero provides a client mapping for accessing
    the Pactas Itero API.}
  spec.description   = %q{pactas_itero provides a client mapping for accessing
    the Pactas Itero API, making it easy to post your data to, adn read your
    data from your Pactas account.}
  spec.homepage      = 'https://github.com/webionate/pactas_itero'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- spec/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency('faraday_middleware', '~> 0.9.1')
  spec.add_dependency('rash', '~> 0.4.0')

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency "rspec", '~> 3.0'
  spec.add_development_dependency("simplecov", "~> 0")
  spec.add_development_dependency("webmock", "~> 1.18", ">= 1.18.0")
end
