namespace :sanity do

  desc "Did you intend to deploy without pushing?"
  task :pushed do
    on roles(:app) do
      unless Capistrano.dry_run?
        system("bin/push-check #{fetch(:repo_url)}")
      end
    end
  end

end
