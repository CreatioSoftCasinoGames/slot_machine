# Settings for production server
set :user, 'application'
server 'slot-rails-1.slotapi.com', :app, :web
server 'slot-rails-2.slotapi.com', :app, :web
set :rvm_type, :system
set :use_sudo, false
set :deploy_via, :remote_cache
set :copy_exclude, [ '.git' ]
set :rvm_ruby_version, 'ruby-2.1.0'
set :port, 22 

set :deploy_to, "/apps/#{application}"
