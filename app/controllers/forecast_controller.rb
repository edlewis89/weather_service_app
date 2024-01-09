class ForecastController < ApplicationController
  def show
    @cached = false
    zip_code = params[:zip_code]
    weather_service = WeatherService.new(Rails.application.credentials.openweathermap[:api_key])

    # This code implements a basic cache-check-fetch-update pattern,
    # ensuring that forecast data is retrieved from the cache when valid and,
    # if necessary, updating the cache with fresh data from the API.
    # Enable/disable caching. By default caching is disabled.
    # Run rails dev:cache to toggle caching.
    if Rails.cache.fetch("forecast_#{zip_code}", expires_in: 30.minutes)
      @forecast, @cached = JSON.parse(Rails.cache.fetch("forecast_#{zip_code}"), object_class: OpenStruct), true
    else
      # Fetch forecast from API
      api_forecast = weather_service.get_forecast_by_zip(zip_code)

      if api_forecast
        # Save forecast to cache
        @forecast = JSON.parse(api_forecast.to_json, object_class: OpenStruct)
        Rails.cache.write("forecast_#{zip_code}", api_forecast.to_json, expires_in: 30.minutes)
      else
        @error = 'Unable to retrieve forecast data.'
      end
    end
  end
end
