# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'activeadmin-orderable/version'

Gem::Specification.new do |gem|
  gem.name          = "activeadmin-orderable"
  gem.version       = Activeadmin::Orderable::VERSION
  gem.authors       = ["Adam McCrea", "Jonathan Gertig"]
  gem.email         = ["adam@adamlogic.com", "jcgertig@gmail.com"]
  gem.description   = %q{Drag and drop reordering interface for ActiveAdmin tables}
  gem.summary       = %q{Drag and drop reordering interface for ActiveAdmin tables}
  gem.homepage      = "https://github.com/jcgertig/activeadmin-orderable"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'activeadmin', '>= 1.0.0.pre1'
  gem.add_development_dependency 'rails', '~> 4.2'
  gem.add_development_dependency 'capybara'
  gem.add_development_dependency 'rspec-rails', '~> 3.3'
  gem.add_development_dependency 'phantomjs'
  gem.add_development_dependency 'poltergeist'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'launchy'
end
