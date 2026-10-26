@varbase-ai-vdb-mariadb @ai @recipes @access @local @development @staging @production
Feature: Varbase AI Recipe - AI VDB: MariaDB - Who can see the database connection
  As a site owner
  I want only the super administrator to see the vector database settings
  So that the database host and user are not shown to anyone else

  Scenario Outline: Check the "<user>" user cannot open the MariaDB provider settings
    Given I am a logged in user with the "<user>" user
     When I go to "/admin/config/ai/vdb_providers/mariadb"
     Then the response status code should be 403
      And I should see "Access denied"
      And I should not see "Current Database"

    Examples:
      | user           |
      | Content editor |
      | Content admin  |
      | SEO admin      |
      | Site admin     |

  Scenario: Check an anonymous visitor cannot open the MariaDB provider settings
    Given I am an anonymous user
     When I go to "/admin/config/ai/vdb_providers/mariadb"
     Then the response status code should be 403
      And I should not see "Current Database"
