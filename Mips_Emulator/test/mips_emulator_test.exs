defmodule MipsEmulatorTest do
  use ExUnit.Case
  doctest MipsEmulator

  test "greets the world" do
    assert MipsEmulator.hello() == :world
  end
end
