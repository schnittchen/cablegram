defmodule CablegramTest do
  use ExUnit.Case
  doctest Cablegram

  test "greets the world" do
    assert Cablegram.hello() == :world
  end
end
