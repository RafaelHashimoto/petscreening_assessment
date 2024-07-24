require 'net/http'
require 'uri'
require 'json'

module DogApi
  class Breeds
    API_BREEDS_ENDPOINT             = 'https://dogapi.dog/api/v2/breeds'
    DOG_API_MAX_REQUESTS_PER_MINUTE = 60
    RATE_LIMITER_WAIT_TIME          = 60

    def self.fetch_all
      Breeds.new.fetch_all
    end

    def initialize
      @next_page     = API_BREEDS_ENDPOINT
      @api_requests  = 0
      @responses     = []
    end

    def fetch_all
      while @next_page.present?
        rate_limit do
          Rails.logger.info("Requesting: #{@next_page}")
          response  = fetch_next_page
          @responses << response['data']
          @next_page = response['links']['next']
        end
      end
    rescue StandardError => e
      Rails.logger.error("DogAPI::Breeds: Error Requesting API #{e}")
    ensure
      return @responses.flatten unless @responses.empty?

      []
    end

    private

    def fetch_next_page
      JSON.parse(get(URI(@next_page)).body)
    end

    def get(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      http.request(Net::HTTP::Get.new(uri.request_uri))
    end

    # The dogapi has a rate limit of 60 requests per minute, see: https://dogapi.dog/terms
    # This is the cheapest way to ensure we're not over requesting the DogApi and exceeding it's rate limits.

    def rate_limit
      if @api_requests < DOG_API_MAX_REQUESTS_PER_MINUTE
        yield
        @api_requests += 1
      else
        sleep RATE_LIMITER_WAIT_TIME
        @api_requests = 0
        yield
      end
    end
  end
end
