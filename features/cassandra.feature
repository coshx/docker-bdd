Feature: Cassandra Cluster
  As a system administrator
  I want to deploy a cassandra cluster
  So I can store and query lots of data

Scenario: Launch a CQL Shell
  Given the services are running
  And I run "cqlsh cassandra -e 'show version'" on "cassandra-dev"
  Then I should see "CQL spec 3.4.2"
  And I should see "Cassandra 3.7"

Scenario: Two Nodes Running
  Given "cassandra" is running with "2" nodes
  And I create the keyspace "test_two" on "cassandra_1"
  And I list the keyspaces on "cassandra_2"
  Then I should see "test_two"
  Then I drop the keyspace "test_two"
