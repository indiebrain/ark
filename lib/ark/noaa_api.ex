defmodule Ark.NoaaApi do

  @noaa_url Application.get_env(:ark, :noaa_observation_base_url)

  import Ark.XmlParser

  def fetch(airport_abbreviation) do
    noaa_url(airport_abbreviation)
    |> send_request
    |> parse_response
  end

  def send_request(url) do
    url
    |> HTTPoison.get
  end

  def noaa_url(airport_abbreviation \\ "KPTW") do
    "#{@noaa_url}/#{airport_abbreviation}.xml"
  end

  def parse_response({ :ok, %{ status_code: 200, body: response_body } }) do
    response_document = document_from_string(response_body)
    %Ark.WeatherConditions{
      location:      value_at('/current_observation/location', response_document),
      temperature_f: value_at('/current_observation/temp_f'  , response_document),
      observed_at:   value_at('/current_observation/observation_time_rfc822', response_document)
    }
  end

  def parse_response({ _, %{ status_code: status, body: response_body } }) do
    raise "Failed to fetch weather: #{status}"
  end

end
