class WeatherService
  include HTTParty

  def initialize(api_key)
    @api_key = api_key
    @base_uri = 'https://api.openweathermap.org/data/2.5/weather'
  end

  def get_forecast_by_zip(zip_code)
    response = make_api_request(zip_code)
    handle_response(response)
  rescue OpenWeatherMapError => e
    Rails.logger.error("OpenWeatherMap API error: #{e.message}")
    nil
  rescue StandardError => e
    Rails.logger.error("Error fetching forecast: #{e.message}")
    nil
  end

  private

  def make_api_request(zip_code)
    # For demonstration purposes, let's assume some API request logic that might raise an exception
    raise StandardError, 'API request failed' unless valid_zip_code?(zip_code)

    response = self.class.get(@base_uri, query: { zip: zip_code, appid: @api_key })

    # Check for specific error response from OpenWeatherMap API
    raise OpenWeatherMapError, response['message'] if !response['cod'] == 200

    response
  end

  def handle_response(response)
    parsed_response = response.parsed_response if response.success?

    raise StandardError, 'Invalid response' if parsed_response['error']

    # HASH
    parsed_response
  end

  def valid_zip_code?(zip_code)
    # Regular expression for a 5-digit number
    zip_code_regex = /\A\d{5}\z/

    # Check if the zip code matches the regular expression
    !zip_code.match(zip_code_regex).nil?
  end
end

# Custom exception class for OpenWeatherMap API errors
class OpenWeatherMapError < StandardError; end