# config/redis.yml
# Redis db configuration file
# development environment
development:
    host: 'localhost'
    port: '6379'

# production environment
production:
    host: 'redis.slits.online'
    port: '6379'

# production environment
beta:
    host: 'localhost'
    port: '6379'
➜  ~  cat config/deploy/production.rb 
# Settings for production server
set :user, 'application'
server 'rails01.slits.online', :app, :web
set :rvm_type, :system
set :use_sudo, false
set :deploy_via, :remote_cache
set :copy_exclude, [ '.git' ]
set :rvm_ruby_version, 'ruby-2.1.0'
set :port, 22 

set :deploy_to, "/apps/#{application}"
