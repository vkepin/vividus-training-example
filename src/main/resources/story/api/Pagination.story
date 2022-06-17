// add property for test-cases
Meta:
    @api
    @epic 
    @feature 

Scenario: Defaul pagination
Meta:
    @testCaseId VLECT=7
    @smoke
When I send HTTP GET to the relative URL '/palette'
Then JSON element value from context by JSON path `$.page` equal to `1`
Then JSON element value from context by JSON path `$.per_page` equal to `${default-page-size}`
When I save JSON element value from context by JSON path `$.total` to STORY variable `palette-total-count`
When I save JSON element value from context by JSON path `$.total_pages` to STORY variable `total-pages`
Then number of JSON elements by JSON path `$.data` is <= ${default-page-size}

Scenario: Validate pagination parameters with condition
When the condition '#eval(${palette-total-count} > 1)' is true I do
|step|
|When I send HTTP GET to the relative URL '/palette?<query>'|
|Then JSON element value from context by JSON path `$.page` equal to `<page>`|
|Then JSON element value from context by JSON path `$.per_page` equal to `<per-page>`|
|Then JSON element value from context by JSON path `$.total_pages` equal to `<total-pages>`|
|Then number of JSON elements by JSON path `$.data` is = ${palette-total-count}|
Examples:
|per-page                            |page|total-pages|query                          |data-count |
|#{eval(${palette-total-count} - 2)} |2   |2          |per_page=<per-page>&page=<page>|2          |

Scenario: Validate pagination parameters
Meta:
    @testCaseId VLECT=8
    @regression
When I send HTTP GET to the relative URL '/palette?<query>'
Then JSON element value from context by JSON path `$.page` equal to `<page>`
Then JSON element value from context by JSON path `$.per_page` equal to `<per-page>`
Then JSON element value from context by JSON path `$.total_pages` equal to `<total-pages>`
Then number of JSON elements by JSON path `$.data` is = <data-count>
Examples:
|per-page                            |page|total-pages            |query                                               |data-count             |
|#{eval(${palette-total-count} - 1)} |2   |2                      |per_page=#{eval(${palette-total-count} - 1)}&page=2 |1                      |
|${palette-total-count}              |1   |1                      |per_page=${palette-total-count}                     |${palette-total-count} |
|1                                   |1   |${palette-total-count} |per_page=1                                          |1                      |
