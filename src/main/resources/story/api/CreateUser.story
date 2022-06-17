Meta:
    @api
    @testCaseId VLECT=6
    @regression

Scenario: Get token
Given request body:
{
    "email": "${api-admin-user}",
    "password": "${api-admin-user-password}"
}
When I send HTTP POST to the relative URL '/login'
Then `${responseCode}` is equal to `200`
When I save JSON element value from context by JSON path `$.token` to STORY variable `loginToken`

Scenario: Create Users
Given request body:
{
    "firstName" : "<firstName>",
    "lastName" : "<lastName>",
    "email" : "<email>",
    "birthday" : "<birthday>"
}
When I add request headers:
|name       |value         |
|Auth-token |${loginToken} |
When I send HTTP POST to the relative URL '/users'
Then `${responseCode}` is equal to `201`
When I save JSON element value from context by JSON path `$.id` to STORY variable `<firstName>.<lastName>Id`
Examples:
story/testdata/users.table

Scenario: Delete Users
When I add request headers:
|name       |value         |
|Auth-token |${loginToken} |
When I send HTTP DELETE to the relative URL '/users/${<firstName>.<lastName>Id}'
Then `${responseCode}` is equal to `204`
And the response does not contain body
Examples:
story/testdata/users.table
