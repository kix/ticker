Feature: Price display
    Scenario: Latest known price is displayed
        Given a price has updated
        When I open root page
        Then I see the latest price