@varbase-ai-vdb-mariadb @ai @recipes @local @development @staging @production
Feature: Varbase AI Recipe - AI VDB: MariaDB - The site's own database stores the vectors
  As a site builder
  I want the MariaDB vector database provider set up on the site's own database and made the default
  So that Varbase AI Search can store and search vectors with no extra service

  Background:
    Given I am a logged in user with the "Webmaster" user

  Scenario: Check the MariaDB provider is ready on the site's own database
     When I go to "/admin/config/ai/vdb_providers/mariadb"
     Then I should see "The MariaDB Vector DB Provider is ready to use!"
      And I should see "uses your existing Drupal database connection"
      And I should see "Vector support available"

  Scenario: Check MariaDB is the default vector database provider
     When I go to "/admin/config/ai/settings"
     Then I should see the "MariaDB as the default vector database" element in the "AI settings"

  Scenario: Check the status report confirms the database supports vectors
     When I go to "/admin/reports/status"
     Then I should see "MariaDB Vector support"
