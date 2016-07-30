Feature: Web Server
  As a developer
  I want to use a web server
  So I can serve up static content without routing through the app

Scenario: nginx installed
  Given the services are running
  And I run "nginx -v" on the "web" service
  Then I should see "nginx"
  And I should see "1.11"

Scenario: nginx running
  Given the services are running
  And I run "curl -i http://web | grep Server" on "web"
  Then I should see "Server: nginx"

Scenario: nginx serving static pages
  Given the services are running
  And I run "curl http://web/test.html | grep '<h1>'" on "web"
  Then I should see "It Works"

Scenario: nginx proxying dynamic pages
  Given the services are running
  And I run "curl http://web/todos | grep '<h1>'" on "web"
  Then I should see "Listing Todos"
