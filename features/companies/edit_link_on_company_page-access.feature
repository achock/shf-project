Feature: Only admin and company members see the button to edit a company

  As the owner of a company (or an admin)
  To protect access to the company info
  Only I can edit it


  Background:
    Given the Membership Ethical Guidelines Master Checklist exists

    Given the following users exist:
      | email                 | admin | member    |
      | emma@happymutts.com   |       | true      |
      | lars@happymutts.com   |       | true      |
      | anna@happymutts.com   |       | true      |
      | bowser@snarkybarky.se |       | true      |
      | admin@shf.se          | true  | false     |

    Given the following payments exist
      | user_email          | start_date | expire_date | payment_type | status | hips_id |
      | emma@happymutts.com | 2017-10-1  | 2017-12-31  | member_fee   | betald | none    |

    Given the following companies exist:
      | name         | email                 | company_number |
      | happy mutts  | emma@happymutts.com   | 5562252998     |
      | snarky barky | bowser@snarkybarky.se | 2120000142     |

    And the following applications exist:
      | user_email            | company_number | state    |
      | emma@happymutts.com   | 5562252998     | accepted |
      | bowser@snarkybarky.se | 2120000142     | accepted |


  Scenario: Visitor does not see edit link for a company
    Given I am Logged out
    And I am the page for company number "5562252998"
    Then I should see t("companies.show.email")
    And I should not see t("companies.edit_company")

  Scenario: Admin does see edit link for company
    Given I am logged in as "admin@shf.se"
    And I am the page for company number "5562252998"
    Then I should see t("companies.show.email")
    And I should see t("companies.edit_company")

  Scenario: Other user does not see edit link for a company
    Given I am logged in as "bowser@snarkybarky.se"
    And I am the page for company number "5562252998"
    Then I should see t("companies.show.email")
    And I should not see t("companies.edit_company")

  @time_adjust
  Scenario: User related to company does see edit link for company
    Given the date is set to "2017-10-01"
    Given I am logged in as "emma@happymutts.com"
    And I am the page for company number "5562252998"
    Then I should see t("companies.show.email")
    And I should see t("companies.edit_company")
