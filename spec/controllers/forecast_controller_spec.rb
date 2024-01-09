require 'rails_helper'

RSpec.describe ForecastController, type: :controller do
  let(:api_key) { 'a68da59ef45b5829cdf0855fb4ff1f84' } # Replace with your API key
  let(:zip_code) { '20152' } # Use a valid zip code for testing

  before { Rails.application.credentials.openweathermap[:api_key] = api_key }

  describe 'GET #show' do
    context 'with a valid zip code' do
      it 'renders the show template' do
        VCR.use_cassette('controller_valid_zip_code') do
          get :show, params: { zip_code: zip_code }
          expect(response).to render_template(:show)
        end
      end
    end

    context 'with an invalid zip code' do
      it 'renders an error message' do
        VCR.use_cassette('controller_invalid_zip_code') do
          get :show, params: { zip_code: 'invalid' }
          expect(assigns(:error)).to be_present
        end
      end
    end
  end
end