ExUnit.start()

defmodule FixtureHelper do
  def read(fixture_name) do
    File.read!(fixture_path(fixture_name))
  end

  def fixture_path(fixture_name) do
    Path.join([fixtures_path, fixture_name])
  end

  def fixtures_path do
    Path.join([System.cwd, "test", "fixtures"])
  end
end
