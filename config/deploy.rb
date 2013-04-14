set :user, 'deploy'
set :domain, 'www.leonoticias.com.ar'
set :application, "leonoticias"

set :repository, "git@github.com:cesarediaz/feeds_reader.git"  # Your clone URL
set :scm, "git"
set :branch, "" #master
set :scm_verbose, true
set :deploy_via, :remote_cache
set :scm_passphrase, "password"  # The deploy user's password
set :deploy_to, "/home/#{user}/#{domain}"
set :use_sudo, true
set :shared_path, "#{deploy_to}/shared"
set :normalize_asset_timestamps, false

#set :default_environment, {
#  'PATH' => "/home/#{user}/.rvm/gems/ruby-1.9.2-p290@artistica/bin:/home/deploy/.rvm/bin:$PATH",
#  'RUBY_VERSION' => 'ruby-1.9.2-p290',
#  'GEM_HOME'     => "/home/#{user}/.rvm/gems/ruby-1.9.2-p290@artistica",
#  'GEM_PATH'     => "/home/#{user}/.rvm/gems/ruby-1.9.2-p290@artistica",
#  'BUNDLE_PATH'  => "/home/#{user}/.rvm/gems/ruby-1.9.2-p290@artistica"
#}


require 'bundler/capistrano'

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))  # Add RVM's lib directory to the load path.
#require "rvm/capistrano"                                # Load RVM's capistrano plugin.
set :rvm_type, :user
#set :rvm_ruby_string, 'ruby-1.9.2-p290@global'             # Or whatever env you want it to run in.
#set :rvm_bin_path, "/usr/local/rvm/bin"



default_run_options[:pty] = true
ssh_options[:forward_agent] = true

role :web, domain                        # Your HTTP server, Apache/etc
role :app, domain                         # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    #run "cd #{latest_release} && rm config/database.yml"
    run "ln -s #{shared_path}/database.yml #{latest_release}/config/database.yml"

    run "cd #{latest_release} && rm -rf #{latest_release}/public/system"

    run "ln -nfs #{shared_path}/system #{release_path}/public/system"

    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
