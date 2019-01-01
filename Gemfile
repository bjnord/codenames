source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis-rails'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
group :development do
  gem 'capistrano-rails'
  gem 'capistrano-rvm'
  gem 'capistrano-nvm', require: false
  gem 'capistrano3-puma'
  # these are needed by net-ssh to support ed25519 keys:
  gem 'rbnacl-libsodium'
  gem 'rbnacl', '~> 4.0.2'  # must be < 5.0
  gem 'ed25519', '~> 1.2.4'  # must be < 2.0
  gem 'bcrypt_pbkdf', '~> 1.0.0'  # must be < 2.0
end

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'bootstrap', '~> 4.1.3'
gem 'jquery-rails'
gem 'responders'
gem 'font-awesome-rails'

group :development, :test do
  gem 'rspec-rails', '~> 3.8.1'
  gem 'guard-rspec', require: false
  gem 'guard-livereload'
  gem 'spring-commands-rspec'
  gem 'faker'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'factory_bot'
  gem 'capybara'
  gem 'database_cleaner'
end
