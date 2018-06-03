require 'rubygems'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.configure do |config|
    config.default_max_wait_time = 10 # seconds
    config.default_driver        = :selenium
end

Given("the latest price is {int}") do |int|
    Rails.cache.write 'rate', int
end
  
When("I set a fixed price of {int} for {int} seconds") do |price, duration|
    in_5_secs = Time.now + duration
    fill_in('Rate', with: price)
    fill_in('Until', with: in_5_secs.strftime('%d/%m/%Y %H:%m'))
    find('[type=submit]').click
end
  
Then("I see a price of {int}") do |price|
    page.has_content? price
end
  
When("I wait for {int} seconds") do |seconds|
    sleep seconds
end
  
When("I open root page") do
    visit '/'
end

Then("I see a price of (\d+)") do |price|
    page.has_content? "$1000"
end

When("I open admin page") do
    visit '/admin'
end

When("I set a fixed price of (\d+) for (\d+) seconds") do |price, duration|
    
end