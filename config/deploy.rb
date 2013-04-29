set :user, 'deploy'
set :domain, 'www.leonoticias.com.ar'
set :application, "leonoticias"

set :repository, "git@github.com:cesarediaz/feeds_reader.git"  # Your clone URL
set :scm, "git"
set :branch, "master" #master
set :scm_verbose, true
set :deploy_via, :remote_cache
set :scm_passphrase, "password"  # The deploy user's password
set :deploy_to, "/home/#{user}/#{domain}"
set :use_sudo, false
set :shared_path, "#{deploy_to}/shared"
set :normalize_asset_timestamps, false


require 'bundler/capistrano'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))  # Add RVM's lib directory to the load path.
set :rvm_type, :user



default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :web, domain                        # Your HTTP server, Apache/etc
role :app, domain                         # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "ln -s #{shared_path}/database.yml #{latest_release}/config/database.yml"

    run "cd #{latest_release} && rm -rf #{latest_release}/public/system"

   run "ln -nfs #{shared_path}/system #{release_path}/public/system"

    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

