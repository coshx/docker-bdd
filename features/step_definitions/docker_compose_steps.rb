$docker_compose_up = ENV['CIRCLECI']

Given /^(?:T|t)he services are running$/ do
  # don't run `docker-compose up` more than once on circle.
  # since it hits an error (Failed to destroy btrfs snapshot: operation not permitted)
  # already running this via circle.yml

  unless $docker_compose_up
    run_cmd "docker-compose build && (docker-compose up -d || true)"
    $docker_compose_up = true
  end
end

When /^I run "([^\"]*)" on (?:|the )"([^\"]*)"(?:| service)$/ do |cmd, service|
  run_cmd "docker-compose run #{service} bash -i -c \"sleep 1; #{cmd}\""
end
