Meta:
    @layout desktop

Scenario: Login successfull
Meta:
    @testCaseId VLECT=1
    @smoke

Given I am on the main application page
When I enter `${default-user}` in field located `id(user-name)`
When I enter `${default-user-password}` in field located `id(password)`
When I click on element located `buttonName(login-button)`
Then number of elements found by `id(shopping_cart_container)` is = `1`

Scenario: Login unsuccessfull
Meta:
    @testCaseId VLECT=2
    @regression

Given I am on the main application page
When I enter `<Username>` in field located `id(user-name)`
When I enter `<Password>` in field located `id(password)`
When I click on element located `buttonName(login-button)`
When I wait until element located `className(error-message-container)` appears
When I change context to element located `className(error-message-container)`
Then the text '<Expected-error>' exists
Examples:
|Username        |Password     |Expected-error                                                            |
|unexisted-user  |secret_sauce |Epic sadface: Username and password do not match any user in this service |
|${default-user} |123321asda   |Epic sadface: Username and password do not match any user in this service |
|${default-user} |             |Epic sadface: Password is required                                        |
|locked_out_user |secret_sauce |Epic sadface: Sorry, this user has been locked out.                       |
