defmodule TwitterTest do
  use ExUnit.Case
  doctest Twitter

  test "greets the world" do
    assert Twitter.hello() == :world
  end
end
