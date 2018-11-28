# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activejob/lock/version'

Gem::Specification.new do |s|
  s.name          = "activejob-lock"
  s.version       = Activejob::Lock::VERSION
  s.authors       = ["adrien"]
  s.email         = ["adrien.montfort@gmail.com"]
  s.summary       = %q{Adapt resque-lock with ActiveJob}
  s.description   = ''
  s.homepage      = 'http://github.com/idolweb/activejob-lock'
  s.license       = "MIT"

  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency 'activejob', '>= 4.2'
  s.add_dependency 'activesupport', '>= 4.2'
  s.add_dependency "resque-lock", "~> 1.1"

  s.add_development_dependency "bundler", "~> 1.7"
  s.add_development_dependency "rake", "~> 10.0"

  s.add_development_dependency "rails"
  s.add_development_dependency "sqlite3"
end
