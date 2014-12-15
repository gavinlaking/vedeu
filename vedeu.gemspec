# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'vedeu'
  spec.version       = '0.2.12'
  spec.authors       = ['Gavin Laking']
  spec.email         = ['gavinlaking@gmail.com']
  spec.summary       = %q{A terminal case of wonderland.}
  spec.description   = %q{A GUI framework for terminal/console applications.}
  spec.homepage      = 'https://github.com/gavinlaking/vedeu'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',            '~> 1.6'
  spec.add_development_dependency 'guard',              '2.8.2'
  spec.add_development_dependency 'guard-bundler',      '2.0.0'
  spec.add_development_dependency 'guard-minitest',     '2.3.2'
  spec.add_development_dependency 'minitest',           '5.4.3'
  spec.add_development_dependency 'minitest-reporters', '1.0.7'
  spec.add_development_dependency 'mocha',              '1.1.0'
  spec.add_development_dependency 'pry',                '0.10.1'
  spec.add_development_dependency 'rake',               '10.3.2'
  spec.add_development_dependency 'simplecov',          '0.9.1'
  spec.add_development_dependency 'yard',               '0.8.7.6'
end
