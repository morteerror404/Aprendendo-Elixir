defmodule AprendendoElixirTest do
  use ExUnit.Case
  doctest AprendendoElixir

  test "greets the world" do
    assert AprendendoElixir.hello() == :world
  end
end
