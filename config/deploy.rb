set(:bundle_without) { [:development, :test] }

 require 'bundler/capistrano'

load 'deploy/assets'

set :application, "beer_app"
set :user, "bcantin"
set :repository, "ssh://git@github.com/OneMT/Beerapp"

set :scm, "git"
set :deploy_to, "/home/bcantin/sites/#{application}"

set :deploy_via, :remote_cache

set :rails_env, "production"
set :branch, "master"
set :use_sudo, false
set :keep_releases, 4

role :app, "72.15.218.77"
role :web, "72.15.218.77"
role :db,  "72.15.218.77", :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 task :symlink_db do
    run "ln -sf #{shared_path}/database.yml #{release_path}/config/database.yml"  
  end
end



after 'deploy:finalize_update', 'deploy:symlink_db'

after 'deploy:restart', 'deploy:cleanup'
