When /^I create the keyspace "([^\"]*)"(?:| on "([^\"]*)")$/ do |keyspace, node|
  strategy = "SimpleStrategy"
  replication_factor = "2" # hard coding until we need to test different ones
  node ||= "cassandra"
  run_cmd "docker-compose run cassandra-dev cqlsh #{node} -e \"create keyspace #{keyspace} with replication={'class': '#{strategy}', 'replication_factor': #{replication_factor}}\""
end

When /^I drop the keyspace "([^\"]*)"(?:| on "([^\"]*)")$/ do |keyspace, node|
  node ||= "cassandra"
  run_cmd "docker-compose run cassandra-dev cqlsh #{node} -e \"drop keyspace '#{keyspace}'\""
end

When /^I list the keyspaces(?:| on "([^\"]*)")$/ do |node|
  node ||= "cassandra"
  run_cmd "docker-compose run cassandra-dev cqlsh #{node} -e \"desc keyspaces\""
end
