defmodule NodesFunTest do
  use ExUnit.Case
  doctest NodesFun

  test "greets the world" do
    assert NodesFun.hello() == :world
  end
end
