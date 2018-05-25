require 'net/http'
TICKER_URL = 'https://blockchain.info/ru/ticker'

class FrontController < ApplicationController
  def index
    @rate = fetch_rate()
  end

  def admin
    @rate = Rails.cache.read('forced_rate') || ""
    expires = Rails.cache.read('forced_expires')
    @until = expires ? (Time.at expires).strftime("%Y-%m-%dT%H:%M:%S") : ""
  end

  def fix_rate
    expires = Time.parse(params[:until]).to_i
    Rails.cache.write 'forced_rate', params[:rate]
    Rails.cache.write 'forced_expires', expires
    Rails.cache.write 'rate', params[:rate]
    Rails.cache.write 'expires', expires

    redirect_to '/admin'
  end

  private
  def fetch_rate
    rate = Rails.cache.read 'rate'
    expiry = Rails.cache.read('expires') || 0
    
    if expiry < Time.current.to_i
      json = JSON.parse(Net::HTTP.get(URI(TICKER_URL)))
      Rails.cache.write 'rate', json['USD']['last']
      Rails.cache.write 'expires', (Time.current + 60.seconds).to_i
    end

    rate
  end
end

