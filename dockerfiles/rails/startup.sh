#!/bin/bash
set -e
bundle install
# TODO find more elegant way to wait for database to be available
sleep 60
bundle exec rake db:create db:migrate
exec bundle exec rackup -p 3000 -o 0.0.0.0
