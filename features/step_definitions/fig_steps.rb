Given /^(?:T|t)he services are running$/ do
  if !$fig_up
    # I hate having a sleep here,
    # but when running on vagrant,
    # the tests run before the server is fully up.
    sleep_cmd = `whoami`.strip == 'vagrant' ? '&& sleep 10' : ''
    
    run_cmd "fig build && (fig up -d || true) #{sleep_cmd}"
    $fig_up = true
  end
end

When /^I run "([^\"]*)" on (?:|the )"([^\"]*)"(?:| service)$/ do |cmd, service|
  run_cmd "fig run #{service} #{cmd}"
end

