require 'net/http'
TICKER_URL = 'https://blockchain.info/ru/ticker'
UPDATE_INTERVAL = 60

def do_fetch
  json = JSON.parse(Net::HTTP.get(URI('https://blockchain.info/ru/ticker')))
  Rails.cache.write 'rate', json['USD']['last']
  Rails.cache.write 'expires', (Time.current + UPDATE_INTERVAL.seconds).to_i
  puts "New rate: " + Rails.cache.read('rate').to_s
end

namespace :rates do
  desc "Fetches newest rate and stores it"
  task fetch: :environment do
    do_fetch()
  end

  desc "Monitors the rate"
  task monitor: :environment do
    puts "Monitoring rate"
    while true do
      do_fetch()
      sleep UPDATE_INTERVAL
    end
  end

  task show: :environment do
    puts "Current rate is: " + Rails.cache.read('rate').to_s
  end
end
