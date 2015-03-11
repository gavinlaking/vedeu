# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'vedeu'
  spec.version       = '0.4.6'
  spec.authors       = ['Gavin Laking']
  spec.email         = ['gavinlaking@gmail.com']
  spec.summary       = %q{A terminal case of wonderland.}
  spec.description   = %q{A GUI framework written in Ruby for building terminal/console applications.}
  spec.homepage      = 'https://github.com/gavinlaking/vedeu'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'aruba',              '0.6.2'
  spec.add_development_dependency 'bundler',            '~> 1.7'
  spec.add_development_dependency 'cucumber',           '1.3.19'
  spec.add_development_dependency 'guard',              '2.12.4'
  spec.add_development_dependency 'guard-bundler',      '2.1.0'
  spec.add_development_dependency 'guard-cucumber',     '1.5.4'
  spec.add_development_dependency 'guard-minitest',     '2.4.4'
  spec.add_development_dependency 'inch',               '0.5.10'
  spec.add_development_dependency 'minitest',           '5.5.1'
  spec.add_development_dependency 'minitest-reporters', '1.0.11'
  spec.add_development_dependency 'mocha',              '1.1.0'
  spec.add_development_dependency 'pry',                '0.10.1'
  spec.add_development_dependency 'pry-byebug',         '3.0.1'
  spec.add_development_dependency 'rake',               '10.4.2'
  spec.add_development_dependency 'ruby-prof',          '0.15.6'
  spec.add_development_dependency 'simplecov',          '0.9.2'
  spec.add_development_dependency 'simplecov-console',  '0.2.0'
  spec.add_development_dependency 'yard',               '0.8.7.6'
end
