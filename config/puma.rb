#!/usr/bin/env puma

# start puma with:
# RAILS_ENV=production bundle exec puma -C ./config/puma.rb

application_path = '/apps/slot_machine'
railsenv = 'production'
directory application_path
environment railsenv
daemonize true
pidfile "#{application_path}/current/tmp/pids/puma-#{railsenv}.pid"
stdout_redirect "#{application_path}/current/log/puma-#{railsenv}.stdout.log", "#{application_path}/current/log/puma-#{railsenv}.stderr.log"
threads 0, 16
bind "unix:///tmp/slot_machine.sock"
