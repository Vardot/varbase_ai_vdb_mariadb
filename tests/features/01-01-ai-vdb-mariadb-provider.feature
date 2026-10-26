@varbase-ai-vdb-mariadb @ai @recipes @local @development @staging @production
Feature: Varbase AI Recipe - AI VDB: MariaDB - The site's own database stores the vectors
  As a site builder
  I want the site's own MariaDB database ready to store and search AI vectors
  So that Varbase AI Search works with no extra service to run

  Scenario: Check the webmaster sees the site's own database is ready to store vectors
    Given I am a logged in user with the "Webmaster" user
     When I go to "/admin/config/ai/vdb_providers/mariadb"
     Then I should see "The MariaDB Vector DB Provider is ready to use!"
      And I should see "uses your existing Drupal database connection"
      And I should see "Vector support available"
     When I go to "/admin/reports/status"
     Then I should see "MariaDB Vector support"
