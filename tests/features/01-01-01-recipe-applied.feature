@varbase-ai @vdb @recipe
Feature: The Varbase AI VDB: MariaDB recipe connects the site to its vector database
  As a Varbase site builder
  I want the recipe to install and configure the MariaDB vector DB provider
  So that Varbase AI Search can store its vectors there

  # The recipe is applied in CI (drush recipe) before these scenarios run, and
  # the CI recipe check has already proved a real vector insert and ranked search.
  # These scenarios check the admin side through the browser.

  Scenario: The provider module is enabled
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/modules"
    Then I should see "MariaDB VDB Provider"
     And I the page should not have PHP errors

  Scenario: The vector database providers page lists the provider
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/ai/vdb_providers"
    Then I should see "MariaDB Configuration"
     And I the page should not have PHP errors

  Scenario: The provider settings page loads
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/config/ai/vdb_providers/mariadb"
    Then I should see "MariaDB Vector DB Configuration"
     And I the page should not have PHP errors

  Scenario: The status report shows MariaDB vector support
    Given I am a logged in user with the "Webmaster" user
    When I navigate to "/admin/reports/status"
    Then I should see "MariaDB Vector support"
     And I the page should not have PHP errors

  Scenario: Anonymous visitors cannot reach the provider settings
    Given I am an anonymous user
    When I navigate to "/admin/config/ai/vdb_providers/mariadb"
    Then I should see "Access denied"
     And I should not see "MariaDB Vector DB Configuration"
     And I the page should not have PHP errors
