# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vedeu/version'

Gem::Specification.new do |spec|
  spec.name          = 'vedeu'
  spec.version       = Vedeu::VERSION
  spec.authors       = ['Gavin Laking']
  spec.email         = ['gavinlaking@gmail.com']
  spec.summary       = %q{A terminal case of wonderland.}
  spec.homepage      = 'http://www.gavinlaking.name/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'aruba',              '0.5.4'
  spec.add_development_dependency 'bundler',            '~> 1.5'
  spec.add_development_dependency 'cucumber',           '1.3.15'
  spec.add_development_dependency 'guard-cucumber',     '1.4.1'
  spec.add_development_dependency 'guard',              '2.6.1'
  spec.add_development_dependency 'guard-minitest',     '2.3.0'
  spec.add_development_dependency 'minitest',           '5.3.4'
  spec.add_development_dependency 'minitest-reporters', '1.0.4'
  spec.add_development_dependency 'mocha',              '1.1.0'
  spec.add_development_dependency 'pry',                '0.10.0'
  spec.add_development_dependency 'rake',               '10.3.2'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov',          '0.8.2'

  spec.add_dependency "virtus"
  spec.add_dependency "yajl-ruby"
end
