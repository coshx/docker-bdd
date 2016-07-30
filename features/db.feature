Feature: Database
  As a developer
  I want to ensure a database is installed
  So I can persist data from my application

Scenario: psql is installed
  Given The services are running
  And I run "psql --version" on the "db" service
  Then I should see "9.5"

Scenario: database is connected
  Given The services are running
  And I run "psql -h db -U postgres -d postgres -c 'select VERSION()'" on the "db" service
  Then I should see "9.5"
