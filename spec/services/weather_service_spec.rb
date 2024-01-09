require 'rails_helper'

RSpec.describe WeatherService do
  let(:api_key) { 'a68da59ef45b5829cdf0855fb4ff1f84' } # Replace with your API key
  let(:weather_service) { described_class.new(api_key) }

  describe '#get_forecast_by_zip' do
    context 'with a valid zip code' do
      let(:zip_code) { '12345' }

      it 'returns forecast data' do
        VCR.use_cassette('valid_zip_code') do
          forecast = weather_service.get_forecast_by_zip(zip_code)
          expect(forecast).to be_present
        end
      end
    end

    context 'with an invalid zip code' do
      let(:zip_code) { 'invalid' }

      it 'returns nil' do
        VCR.use_cassette('invalid_zip_code') do
          forecast = weather_service.get_forecast_by_zip(zip_code)
          expect(forecast).to be_nil
        end
      end
    end
  end
end