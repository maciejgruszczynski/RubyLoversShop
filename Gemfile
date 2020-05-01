source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'pg', '>= 0.18', '< 2.0'
gem 'rails', '~> 6.0.2', '>= 6.0.2.1'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'turbolinks', '~> 5.2', '>= 5.2.1'
gem 'money-rails', '~>1.12'
gem 'will_paginate', '~> 3.1.0'
gem 'pg_search', '~> 2.3', '>= 2.3.2'
gem 'dry-monads', '~> 1.3', '>= 1.3.5'

group :development, :test do
  gem 'database_cleaner', '~> 1.5', '>= 1.5.3'
  gem 'pry-rails'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rubocop', '~> 0.81.0'
  gem 'rubocop-performance', '~> 1.5', '>= 1.5.2'
  gem 'rubocop-rails', '~> 2.5', '>= 2.5.1'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'rack_session_access', '~> 0.2.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
