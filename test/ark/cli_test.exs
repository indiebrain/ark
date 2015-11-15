defmodule Ark.CLITest do

  use ExUnit.Case
  import ExUnit.CaptureIO
  import Ark.CLI


  test "parse_args parses the airport abbreviation from the input arguments list" do
    arguments = ["expected_airport_abbreviation"]

    { airport_abbreviation } = parse_args(arguments)

    assert("expected_airport_abbreviation" == airport_abbreviation)
  end

  test "parse_args raises an ArgumentError when an airport_abbreviation is not present in the arguments list" do
    arguments = []

    assert_raise(
      ArgumentError,
      "Airport Abbreviation is required",
      fn () ->
        parse_args(arguments)
      end
    )
  end

  test "print_results prints a formatted weather report to standard output" do
    expected_report = """


    ====================
    Weather Conditions at Example Location
    Last Observation: Sat, 14 Nov 2015 23:54:00 -0500
    --------------------
    Temperature (f): 72


    """
    weather_conditions = %Ark.WeatherConditions{
      location: 'Example Location',
      temperature_f: '72',
      observed_at: 'Sat, 14 Nov 2015 23:54:00 -0500'
    }

    report = capture_io(
      fn() ->
        print_results(weather_conditions)
      end
    )

    assert(expected_report == report)
  end

end
