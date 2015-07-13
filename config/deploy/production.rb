# Settings for production server
set :user, 'w3villa'
server '52.27.233.56', :app, :web, :db, :primary => true
server '52.27.111.246', :app, :web
set :rvm_type, :user
set :use_sudo, false
set :deploy_via, :remote_cache
set :rvm_ruby_version, 'ruby-2.1.0'
set :port, 22 

set :deploy_to, "/home/#{user}/#{application}"
