@varbase-ai-vdb-mariadb @ai @recipes @a11y @local @development @staging @production
Feature: Varbase AI Recipe - AI VDB: MariaDB - Accessible provider page
  As a site administrator who uses assistive technology
  I want the vector database page to work with a keyboard and a screen reader
  So that I can check the vector database like anyone else

  Scenario: Check the MariaDB provider page gives every field a label and every link a name
    Given I am a logged in user with the "Webmaster" user
     When I go to "/admin/config/ai/vdb_providers/mariadb"
     Then every form field should have an accessible label
      And every link should have an accessible name
      And every ARIA role should be valid
