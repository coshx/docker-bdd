Feature: App Server
  As a developer
  I want to launch an app server through docker
  So I can develop locally without dealing with dependencies

Scenario: Ruby Installed
  Given the services are running
  And I run "ruby -v" on "app"
  Then I should see "2.3"

Scenario: Rails Installed
  Given the services are running
  And I run "rails -v" on "app"
  Then I should see "5.0"

Scenario: Rails Running
  Given the services are running
  And I run "curl http://app:3000 |grep '<h1>'" on "app"
  Then I should see "Yay!"

Scenario: Rails App Test Suite Passes
  Given I run "rake" on "dev"
  Then I should see "0 failures"
  And I should see "0 errors"
