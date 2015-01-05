Given /^(?:T|t)he services are running$/ do
  # don't run `fig up` more than once on circle.
  # since it hits an error (Failed to destroy btrfs snapshot: operation not permitted)
  # already running this via circle.yml
  $fig_up = ENV['CIRCLECI']
  
  unless $fig_up
    # I hate sleeping here,
    # but when running on vagrant,
    # rails needs some more time.
    sleep_cmd = `whoami`.strip == 'vagrant' ? '&& sleep 10' : ''
    
    run_cmd "fig build && (fig up -d || true) #{sleep_cmd}"
    $fig_up = true
  end
end

When /^I run "([^\"]*)" on (?:|the )"([^\"]*)"(?:| service)$/ do |cmd, service|
  run_cmd "fig run #{service} #{cmd}"
end

