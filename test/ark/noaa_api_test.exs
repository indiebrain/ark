defmodule Ark.NoaaApiTest do

  use ExUnit.Case
  import Ark.NoaaApi

  test "noaa_url returns a default url" do
    assert(noaa_url == "http://w1.weather.gov/xml/current_obs/KPTW.xml")
  end

  test "noaa_url returns the url of the weather report for the given airport_abbreviation" do
    assert(noaa_url("TEST") == "http://w1.weather.gov/xml/current_obs/TEST.xml")
  end

  test "parse_response returns a WeatherConditions struct when the request is successful" do
    body = FixtureHelper.read("noaa_current_obs.xml")
    successful_response = {
      :ok,
      %{ status_code: 200, body: body }
    }

    parsed_response = parse_response(successful_response)

    noaa_weather_conditions = %Ark.WeatherConditions{
      location: 'Pottstown, Pottstown Limerick Airport, PA',
      temperature_f: '35.0',
      observed_at: 'Sat, 14 Nov 2015 23:54:00 -0500'
    }
    assert(parsed_response == noaa_weather_conditions)
  end
end
