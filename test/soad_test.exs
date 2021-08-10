defmodule SoadTest do
  use ExUnit.Case
  doctest Soad

  test "greets the world" do
    assert Soad.hello() == :world
  end
end
