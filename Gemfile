source 'https://rubygems.org'

ruby File.read(".ruby-version").strip

gem 'asset_bom_removal-rails', '~> 1.0.0'
gem 'dalli'
gem 'gds-api-adapters', '~> 50.6'
gem 'govuk_ab_testing', '~> 2.4'
gem 'govuk_frontend_toolkit', '7.2.0'
gem 'govuk_publishing_components', '~> 3.0.2'
gem 'htmlentities', '4.3.4'
gem 'logstasher', '1.2.2'
gem 'plek', '1.11'
gem 'rack_strip_client_ip', '~> 0.0.2'
gem 'rails', '~> 5.1.3'
gem 'rails-controller-testing', '~> 1.0'
gem 'rails-i18n', '>= 4.0.4'
gem 'rails_translation_manager', '~> 0.0.2'
gem 'sass-rails', '~> 5.0.4'
gem 'slimmer', '~> 11.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn', '4.8'

gem 'govuk_app_config', '~> 0.3.0'
gem 'govuk_navigation_helpers', '~> 8.0.0'

group :development, :test do
  gem 'govuk-lint'
  gem 'govuk_schemas'
  gem 'jasmine-rails', github: 'alphagov/jasmine-rails', branch: 'fix-monkey-patch'
  gem 'pry-byebug'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'wraith', '~> 4.2'
end

group :test do
  gem 'capybara'
  gem 'mocha'
  gem 'poltergeist', require: false
  gem 'webmock', '~> 3.1.1', require: false
end
