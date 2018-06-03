require 'rubygems'

Given("a price has updated") do
  Rails.cache.write 'rate', 1000
end

When("I open root page") do
    visit root_path
end

Then("I see the latest price") do
    expect(page).to have_content "$1000"
end