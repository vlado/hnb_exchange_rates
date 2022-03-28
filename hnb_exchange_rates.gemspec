# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hnb_exchange_rates/version'

Gem::Specification.new do |spec|
  spec.name          = "hnb_exchange_rates"
  spec.version       = HnbExchangeRates::VERSION
  spec.authors       = ["Vlado Cingel"]
  spec.email         = ["vladocingel@gmail.com"]
  spec.description   = %q{Fetch exchange rates from from www.hnb.hr (Croatian National Bank)}
  spec.summary       = %q{Fetch exchange rates from from www.hnb.hr (Croatian National Bank)}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", "~> 5.3.2"
  spec.add_development_dependency "webmock", "~> 1.17.4"
end
