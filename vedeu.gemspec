# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vedeu/version'

Gem::Specification.new do |spec|
  spec.name          = "vedeu"
  spec.version       = Vedeu::VERSION
  spec.authors       = ["Gavin Laking"]
  spec.email         = ["gavinlaking@gmail.com"]
  spec.summary       = %q{A terminal case of wonderland.}
  spec.homepage      = "http://www.gavinlaking.name/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "aruba"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-cucumber"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-nav"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov"

  spec.add_dependency "curses", "1.0.1"
end
