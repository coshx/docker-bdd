Then /^I should see "([^\"]*)"$/ do |str|
  assert_match(/#{str}/, @output)
end
