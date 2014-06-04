# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'designmodo/startup_framework/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "designmodo-startup_framework-rails"
  spec.version       = Designmodo::StartupFramework::Rails::VERSION
  spec.authors       = ["Vertmac"]
  spec.email         = ["info@vertmac.com"]
  spec.description   = %q{designmodo-startup_framework-rails integrates Startup Framework for Rails 3 and 4 Asset Pipelines}
  spec.summary       = %q{Startup Framework for Rails 3 and 4 Asset Pipelines}
  spec.homepage      = "https://github.com/vertmac/designmodo-startup_framework-rails"
  spec.license       = "LGPL"

  spec.files         = Dir["lib/**/*"] + ["LICENSE.txt", "Rakefile", "README.md"]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'less-rails-bootstrap'
  spec.add_runtime_dependency 'jquery-rails', '>= 2.2.1'
  spec.add_runtime_dependency 'jquery-ui-rails', '>= 4.0.3'
  spec.post_install_message = "" \
  "**********************************************\n\n" \
  "One *must* run `rails generate startup_framework:install <Startup Framework Directory>`\n" \
  "when gem updated\n\n" \
  "**********************************************"
end