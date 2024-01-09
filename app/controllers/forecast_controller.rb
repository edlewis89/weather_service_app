class ForecastController < ApplicationController
  def show
    zip_code = params[:zip_code]
    weather_service = WeatherService.new(Rails.application.credentials.openweathermap[:api_key])

    # Check if forecast is in cache
    forecast = Forecast.find_by(zip_code: zip_code)

    if forecast&.expires_at && forecast.expires_at > Time.now
      @forecast = JSON.parse(forecast.data)
      @cached = true
    else
      # Fetch forecast from API
      @forecast = weather_service.get_forecast_by_zip(zip_code)

      if @forecast
        # Save forecast to cache
        Forecast.create(zip_code: zip_code, data: @forecast.to_h.to_json, expires_at: Time.now + 30.minutes)
      else
        @error = 'Unable to retrieve forecast data.'
      end
    end
  end
end
