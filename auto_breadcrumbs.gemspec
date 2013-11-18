# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'auto_breadcrumbs/version'

Gem::Specification.new do |spec|
  spec.name          = 'auto_breadcrumbs'
  spec.version       = AutoBreadcrumbs::VERSION
  spec.authors       = ['Evgeny Li']
  spec.email         = ['exaspark@gmail.com']
  spec.description   = %q{Automatically add breadcrumbs to each page by using locales}
  spec.summary       = %q{Automatically adding breadcrumbs by using locales}
  spec.homepage      = 'https://github.com/exAspArk/auto_breadcrumbs'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'breadcrumbs_on_rails'

  spec.add_development_dependency 'activemodel'

  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'poltergeist'
end
