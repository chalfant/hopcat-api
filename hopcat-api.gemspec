# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hopcat/api/version'

Gem::Specification.new do |spec|
  spec.name          = "hopcat-api"
  spec.version       = Hopcat::Api::VERSION
  spec.authors       = ["Chris Chalfant"]
  spec.email         = ["chalfants@gmail.com"]
  spec.summary       = %q{Scrape hopcat's draft list}
  spec.description   = %q{Scrape hopcat's draft list}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "nokogiri"
end
