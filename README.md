# Ark

A CLI client to the NOAA weather conditions XML API.

## Dependencies

  - erlang-xmerl

## Running Tests

    $ mix test

## Building

    $ mix deps.get
    ...
    $ mix escript.build

## Usage

### In IEx

    iex> Ark.CLI.run(["<airport_code>"])

Example:

    iex(1)> Ark.CLI.run(["KPHL"])


    ====================
    Weather Conditions at Philadelphia, Philadelphia International Airport, PA
    Last Observation: Sun, 15 Nov 2015 15:54:00 -0500
    --------------------
    Temperature (f): 61.0


    :ok

### With Built Escript Binary

    $ ./ark KPHL

    ====================
    Weather Conditions at Philadelphia, Philadelphia International Airport, PA
    Last Observation: Sun, 15 Nov 2015 15:54:00 -0500
    --------------------
    Temperature (f): 61.0
