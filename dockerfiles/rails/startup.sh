#!/bin/bash
set -e
bundle install
bundle exec rake db:create db:migrate
exec bundle exec rackup -p 3000 -o 0.0.0.0

