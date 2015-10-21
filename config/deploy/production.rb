# Settings for production server
set :user, 'application'
server 'rails01.slotvasco.com', :app, :web
server 'rails02.slotvasco.com', :app, :web
set :rvm_type, :system
set :use_sudo, false
set :deploy_via, :remote_cache
set :copy_exclude, [ '.git' ]
set :rvm_ruby_version, 'ruby-2.1.0'
set :port, 22 

set :deploy_to, "/apps/#{application}"
