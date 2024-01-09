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
    raise StandardError, 'API request failed' if zip_code == 'error'

    response = self.class.get(@base_uri, query: { zip: zip_code, appid: @api_key })

    # Check for specific error response from OpenWeatherMap API
    raise OpenWeatherMapError, response['message'] if response['cod'] == 401

    # Check for specific error response from OpenWeatherMap API
    raise OpenWeatherMapError, response['message'] if response['cod'] == 404

    response
  end

  def handle_response(response)
    # Your existing response handling logic here
    parsed_response = response.parsed_response if response.success?

    raise StandardError, 'Invalid response' if parsed_response['error']

    JSON.parse(response.body, object_class: OpenStruct)
  end
end

# Custom exception class for OpenWeatherMap API errors
class OpenWeatherMapError < StandardError; end