Meta: 
   @layout desktop 
   @visual

Scenario: Login
Given I am on the main application page
When I login in the application with `${default-user}` and `${default-user-password}`

Scenario: Create baseline
When I ESTABLISH baseline with `expected` ignoring:
|ELEMENT|
|tagName(img)|

Scenario: Validate against baseline
When I click on element located `id(add-to-cart-sauce-labs-backpack)`
When I click on element located `id(add-to-cart-sauce-labs-fleece-jacket)`
When I COMPARE_AGAINST baseline with `expected` ignoring:
|ELEMENT|
|tagName(img)|
