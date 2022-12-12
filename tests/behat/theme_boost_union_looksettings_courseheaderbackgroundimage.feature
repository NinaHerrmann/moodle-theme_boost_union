@theme @theme_boost_union @theme_boost_union_looksettings @theme_boost_union_looksettings_courseheaderbackgroundimage
Feature: Configuring the theme_boost_union plugin for with a default course image "Look" page
  In order to use the features
  As admin
  I need to be able to configure the theme Boost Union plugin

  Background:
    Given the following "users" exist:
      | username |
      | student1 |
      | teacher1 |
    And the following "courses" exist:
      | fullname | shortname |
      | Course 1 | C1        |
      | Course 2 | C2        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | teacher1 | C2     | editingteacher |
      | student1 | C1     | editingteacher |
      | student1 | C2     | editingteacher |

  @_file_upload @javascript
  Scenario Outline: Setting: Coursebackgroundimage - Display coursebackgroundimage when images are enabled and image is uploaded.
    Given the following config values are set as admin:
      | config                       | value     | plugin            |
      | coursebackgroundimageenabled | yes       | theme_boost_union |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I click on "Settings" "link"
    And I upload "theme/boost_union/tests/fixtures/login_bg1.jpg" file to "Course image" filemanager
    And I press "Save and display"
    And I am on site homepage
    And I log out
    And I am on site homepage
    And I follow "Log in"
    When I log in as "<role>"
    And I am on "Course 1" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg1.jpg')]" "xpath_element" should exist
    And I am on "Course 2" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg1.jpg')]" "xpath_element" should not exist
    Examples:
      | role      |
      | student1  |
      | teacher1  |

  @_file_upload @javascript
  Scenario Outline: Setting: Coursebackgroundimage - Display no image if we do not have a default image and course does not have an image.
    Given the following config values are set as admin:
      | config                       | value     | plugin            |
      | coursebackgroundimageenabled | yes       | theme_boost_union |
    When I log in as "<role>"
    And I am on "Course 1" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg1.jpg')]" "xpath_element" should not exist
    Examples:
      | role      |
      | student1  |
      | teacher1  |

  @_file_upload @javascript
  Scenario Outline: Setting: Coursebackgroundimage - Do not display coursebackgroundimage when images are disabled and image is uploaded.
    Given the following config values are set as admin:
      | config                       | value     | plugin            |
      | coursebackgroundimageenabled | no        | theme_boost_union |
    When I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I click on "Settings" "link"
    And I upload "theme/boost_union/tests/fixtures/login_bg1.jpg" file to "Course image" filemanager
    And I press "Save and display"
    And I am on site homepage
    And I log out
    And I am on site homepage
    And I follow "Log in"
    When I log in as "<role>"
    And I am on "Course 1" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg1.jpg')]" "xpath_element" should not exist
    Examples:
      | role      |
      | student1  |
      | teacher1  |

  @_file_upload @javascript
  Scenario: Setting: Coursebackgroundimage - Do display default coursebackgroundimage when course does not have an image.
    Given the following config values are set as admin:
      | config                       | value     | plugin            |
      | coursebackgroundimageenabled | yes       | theme_boost_union |
    When I log in as "admin"
    And I navigate to "Appearance > Boost Union > Look" in site administration
    And I click on "Page" "link"
    And I upload "theme/boost_union/tests/fixtures/login_bg2.jpg" file to "Default image" filemanager
    And I press "Save changes"
    And I am on site homepage
    And I log out
    And I am on site homepage
    And I follow "Log in"
    When I log in as "teacher1"
    And I am on "Course 1" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '1/theme_boost_union/coursebackgroundimagedefault/0/login_bg2.jpg')]" "xpath_element" should exist
    And I am on "Course 2" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '1/theme_boost_union/coursebackgroundimagedefault/0/login_bg2.jpg')]" "xpath_element" should exist

  @_file_upload @javascript
  Scenario Outline: Setting: Coursebackgroundimage - Do display default image until course image is uploaded.
    Given the following config values are set as admin:
      | config                       | value     | plugin            |
      | coursebackgroundimageenabled | yes       | theme_boost_union |
    When I log in as "admin"
    And I navigate to "Appearance > Boost Union > Look" in site administration
    And I click on "Page" "link"
    And I upload "theme/boost_union/tests/fixtures/login_bg2.jpg" file to "Default image" filemanager
    And I press "Save changes"
    And I am on site homepage
    And I log out
    And I am on site homepage
    And I follow "Log in"
    When I log in as "teacher1"
    And I am on "Course 2" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '1/theme_boost_union/coursebackgroundimagedefault/0/login_bg2.jpg')]" "xpath_element" should exist
    And I click on "Settings" "link"
    And I upload "theme/boost_union/tests/fixtures/login_bg1.jpg" file to "Course image" filemanager
    And I press "Save and display"
    And I am on site homepage
    And I log out
    And I am on site homepage
    And I follow "Log in"
    When I log in as "<role>"
    And I am on "Course 2" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '1/theme_boost_union/coursebackgroundimagedefault/0/login_bg2.jpg')]" "xpath_element" should not exist
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg1.jpg')]" "xpath_element" should exist
    Examples:
      | role      |
      | student1  |
      | teacher1  |

  @_file_upload @javascript
  Scenario Outline: Setting: Coursebackgroundimage - do display image of current course.
    Given the following config values are set as admin:
      | config                       | value     | plugin            |
      | coursebackgroundimageenabled | yes       | theme_boost_union |
    When I log in as "teacher1"
    And I am on "Course 2" course homepage
    And I click on "Settings" "link"
    And I upload "theme/boost_union/tests/fixtures/login_bg1.jpg" file to "Course image" filemanager
    And I press "Save and display"
    And I am on "Course 1" course homepage
    And I click on "Settings" "link"
    And I upload "theme/boost_union/tests/fixtures/login_bg2.jpg" file to "Course image" filemanager
    And I press "Save and display"
    And I am on site homepage
    And I log out
    And I am on site homepage
    And I follow "Log in"
    When I log in as "<role>"
    And I am on "Course 2" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg2.jpg')]" "xpath_element" should not exist
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg1.jpg')]" "xpath_element" should exist
    And I am on "Course 1" course homepage
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg2.jpg')]" "xpath_element" should exist
    Then "//div[@id='coursebackgroundimage' and contains(@style, '/course/overviewfiles/login_bg1.jpg')]" "xpath_element" should not exist
    Examples:
      | role      |
      | student1  |
      | teacher1  |
