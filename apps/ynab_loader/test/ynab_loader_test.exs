defmodule YNABLoaderTest do
  use ExUnit.Case
  doctest YNABLoader

  test "greets the world" do
    assert YNABLoader.hello() == :world
  end
end
