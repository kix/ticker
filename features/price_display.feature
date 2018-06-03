Feature: Price display
    Scenario: Price can be fixed
        When I open admin page
        And I set a fixed price of 1000 for 5 seconds
        And I open root page
        Then I see a price of 1000
        When I wait for 5 seconds
        And the latest price is 7500
        And I open root page
        Then I see a price of 7500
    Scenario: Latest known price is displayed
        Given the latest price is 7500
        When I open root page
        Then I see a price of 7500