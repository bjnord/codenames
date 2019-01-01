# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "codenames"
set :repo_url, "git@github.com:bjnord/codenames.git"
set :rvm_ruby_version, gemfile_ruby_version

# Sanity check before deploying
before "deploy:starting", "sanity:pushed"

# Create production SQLite DB if not present
before "deploy:check:linked_files", "deploy:create_db"

# Default branch is :master
# set :branch, "master"
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for keep_releases is 5
set :keep_releases, 8

# Default deploy_to directory is /var/www/my_app_name
# NB set this in config/deploy/*.rb
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "db/production.sqlite3"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

###
# Rails-specific options ("capistrano/rails")
###

# If the environment differs from the stage name
# set :rails_env, 'staging'

# Defaults to :db role
# "it's recommended to set the role to :app instead of :db"
set :migration_role, :app

# Defaults to the primary :db server
# set :migration_servers, -> { primary(fetch(:migration_role)) }

# Defaults to false
# Skip migration if files in db/migrate were not modified
# set :conditionally_migrate, true

# Defaults to [:web]
# set :assets_roles, [:web, :app]

# Defaults to 'assets'
# This should match config.assets.prefix in your rails config/application.rb
# set :assets_prefix, 'prepackaged-assets'

# Defaults to ["/path/to/release_path/public/#{fetch(:assets_prefix)}/.sprockets-manifest*", "/path/to/release_path/public/#{fetch(:assets_prefix)}/manifest*.*"]
# This should match config.assets.manifest in your rails config/application.rb
# set :assets_manifests, ['app/assets/config/manifest.js']

# RAILS_GROUPS env value for the assets:precompile task. Default to nil.
# set :rails_assets_groups, :assets

# If you need to touch public/images, public/javascripts, and public/stylesheets on each deploy
# set :normalize_asset_timestamps, %w{public/images public/javascripts public/stylesheets}

# Defaults to nil (no asset cleanup is performed)
# If you use Rails 4+ and you'd like to clean up old assets after each deploy,
# set this to the number of versions to keep
# set :keep_assets, 2

###
# NVM-specific options ("capistrano/nvm")
###

set :nvm_node, 'v8.10.0'

# Default installation type (or change to :system)
# set :nvm_type, :user

# Default roles
# set :nvm_roles, :all

# Default bins
# set :nvm_map_bins, %w{node npm yarn}
