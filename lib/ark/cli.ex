defmodule Ark.CLI do

  def main(argv) do
    argv
    |> run
  end

  def run(argv) do
    argv
    |> parse_args
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv)

    case parse do
      { _, [airport_abbreviation], _ } -> { airport_abbreviation }
      _ -> raise ArgumentError, "Airport Abbreviation is required"
    end
  end

  def process({ airport_abbreviation }) do
    Ark.NoaaApi.fetch(airport_abbreviation)
    |> print_results
  end

  def print_results(weather_conditions) do
    IO.puts("\n")
    IO.puts(String.duplicate("=", 20))
    IO.puts("Current Weather Conditions")
    IO.puts(String.duplicate("-", 20))
    IO.puts("Location: #{weather_conditions.location}")
    IO.puts("Temperature(f): #{weather_conditions.temperature_f}")
    IO.puts("\n")
  end
end
