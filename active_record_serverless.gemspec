lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_record_serverless/version'

Gem::Specification.new do |spec|
  spec.name          = 'active_record_serverless'
  spec.version       = ActiveRecordServerless::VERSION
  spec.authors       = ['Maddie Schipper']
  spec.email         = ['me@maddiesch.com']

  spec.summary       = 'ActiveRecord Serverless handle AWS Aurora Serverless'
  spec.description   = 'ActiveRecord Serverless handle AWS Aurora Serverless'
  spec.homepage      = 'https://github.com/maddiesch/active_record_serverless'
  spec.license       = 'MIT'

  spec.files         = Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activerecord', '>= 4.0.0', '< 7.0'
  spec.add_runtime_dependency 'activesupport', '>= 4.0.0', '< 7.0'

  spec.add_development_dependency 'bundler',     '~> 2.0'
  spec.add_development_dependency 'pry',         '~> 0.12'
  spec.add_development_dependency 'rake',        '~> 10.0'
  spec.add_development_dependency 'rspec-rails', '~> 3.8'
  spec.add_development_dependency 'simplecov',   '~> 0.16'
  spec.add_development_dependency 'sqlite3',     '~> 1.3'
end
