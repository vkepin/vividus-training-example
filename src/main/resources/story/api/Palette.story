Meta:
    @api
    @regression

Scenario: Upload Palette sorted by registration year
Meta:
    @testCaseId VLECT=8

Given request body:
{
    "name" : "<name>",
    "year" : "<registered>",
    "color" : "<color_code>",
    "pantone_value" : "<pantone>"
}
When I send HTTP POST to the relative URL '/users'
Then `${responseCode}` is equal to `201`
Then JSON element value from context by JSON path `$.id` matches `\d+`
Then JSON element value from context by JSON path `$.createdAt` contains `#{generateDate(P)}`
Examples:
{transformer=MERGING, mergeMode=rows, tables=\{transformer=FROM_CSV\, csvPath=/story/testdata/palette.csv\}}
{transformer=SORTING, byColumns=registered}
|name      |registered |color_code |pantone |
|tigerlily |2004       |#E2583E    |17-1456 |
