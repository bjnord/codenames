require 'pp'

namespace :doctor do

  desc "Display relevant remote environment variables."
  task :shell_env do
    on roles(:all) do
      unless Capistrano.dry_run?
        execute "env | egrep 'RACK_ENV|RAILS_ENV|DATABASE_URL|REDIS_URL|MEMCACHE_SERVERS|SECRET_KEY_BASE|RUBY_VERSION' | sort"
      end
    end
  end

end
