# lib/latest_stock_price/client.rb
require 'net/http'
require 'json'
require 'uri'

module LatestStockPrice
  class Client
    BASE_URL = 'https://latest-stock-price.p.rapidapi.com'

    def initialize(api_key)
      @api_key = api_key
    end

    def price(symbol)
      endpoint = "/price/#{symbol}"
      get_request(endpoint)
    end

    def prices(symbols)
      endpoint = "/prices/#{symbols.join(',')}"
      get_request(endpoint)
    end

    def price_all
      endpoint = "/price_all"
      get_request(endpoint)
    end

    private

    def get_request(endpoint)
      uri = URI.parse("#{BASE_URL}#{endpoint}")
      request = Net::HTTP::Get.new(uri)
      request["X-RapidAPI-Key"] = @api_key
      request["X-RapidAPI-Host"] = "latest-stock-price.p.rapidapi.com"

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      JSON.parse(response.body)
    rescue StandardError => e
      { error: e.message }
    end
  end
end