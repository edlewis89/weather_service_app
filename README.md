# README
# Weather Forecast App

![Weather App Logo](path/to/your/logo.png)

## Description

The Weather Forecast App is a Ruby on Rails application that allows users to retrieve weather forecasts based on zip codes. The application integrates with the OpenWeatherMap API to provide real-time weather data.

## Features

- Retrieve current temperature and weather conditions for a given zip code.
- Display high/low temperature and extended forecast details.
- Cache forecast details for 30 minutes to improve performance.
- Indicator to show if the result is pulled from the cache.

## Installation

### Prerequisites

- Ruby (version x.x.x)
- Rails (version x.x.x)
- Redis (for caching store)

### Steps

1. **Clone the repository:**

    ```bash
    git clone git@github.com:edlewis89/weather_service_app.git
    ```

2. **Install dependencies:**

    ```bash
    bundle install
    ```

3. **Set up the database:**

    ```bash
    rails db:create
    rails db:migrate
    ```

4. **Configure API Key:**

    - Obtain an API key from [OpenWeatherMap](https://openweathermap.org/) and update it in your application (e.g., in `config/application.yml`).
    - Create a file to store your API key securely. Use Rails credentials for this purpose:
    
   ```bash
   EDITOR=vim rails credentials:edit
   ```
   - Add the following to your config/credentials.yml.enc file:

   ```bash
   openweathermap:
     api_key: YOUR_OPENWEATHERMAP_API_KEY
   ```
   
6. **Start the server:**

    ```bash
    rails server
    ```

6. **Open your browser and navigate to [http://localhost:3000](http://localhost:3000) to use the application.**

## Usage

1. Enter a valid zip code in the search bar. (http://localhost:3000/forecast/20152)
2. View the current weather details, including current temperature.
3. Extended forecast details are available, including high/low temperatures.
4. Cached indicator: If the result is pulled from the cache, an indicator will be displayed.

## Contributing

   ...
## License

   ...

## Acknowledgements

- [OpenWeatherMap](https://openweathermap.org/) for providing the weather data API.