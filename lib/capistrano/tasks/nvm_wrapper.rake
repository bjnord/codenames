# based on <https://github.com/koenpunt/capistrano-nvm/issues/25#issuecomment-321570172>

# NVM is nice, but it takes a half-second to load; this means every
# remote Capistrano task pays that penalty, which really slows things
# down. So we add "nvm run" to only the remote Capistrano tasks that
# need the JS runtime available.

namespace :nvm do
  namespace :wrapper do
    task :wrap => [:'nvm:map_bins'] do
      on roles(:web) do
        SSHKit.config.command_map.prefix['rake'].unshift(nvm_prefix)
      end
    end

    task :unwrap do
      on roles(:web) do
        SSHKit.config.command_map.prefix['rake'].delete(nvm_prefix)
      end
    end

    def nvm_prefix
      fetch(
        :nvm_prefix, -> {
          "nvm run"
        }
      )
    end

    before 'deploy:assets:precompile', 'nvm:wrapper:wrap'
    after 'deploy:assets:precompile', 'nvm:wrapper:unwrap'

    task :db_wrap => [:'nvm:map_bins'] do
      on roles(:web) do
        SSHKit.config.command_map.prefix['rake'].unshift(nvm_prefix)
      end
    end

    task :db_unwrap do
      on roles(:web) do
        SSHKit.config.command_map.prefix['rake'].delete(nvm_prefix)
      end
    end

    before 'deploy:migrating', 'nvm:wrapper:db_wrap'
    after 'deploy:migrating', 'nvm:wrapper:db_unwrap'
  end
end
