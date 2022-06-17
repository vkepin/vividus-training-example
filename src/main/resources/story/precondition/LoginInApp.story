Meta:
    @smoke
    @regression

Scenario: Login in the application
Given I am on the main application page
When I login in the application with `${default-user}` and `${default-user-password}`
