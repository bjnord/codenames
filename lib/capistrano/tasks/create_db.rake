namespace :deploy do

  desc 'Create production SQLite DB if not present.'
  task :create_db do
    # <https://stackoverflow.com/a/20876350/291754>
    # <https://github.com/capistrano/sshkit/blob/master/EXAMPLES.md>
    on roles(:db) do
      unless test("[ -f #{shared_path}/db/production.sqlite3 ]")
        run "sqlite3 -batch #{shared_path}/db/production.sqlite3 '.tables'"
      end
    end
  end

end
