defmodule MetaInterpreterTest do
  use ExUnit.Case
  doctest MetaInterpreter

  test "greets the world" do
    assert MetaInterpreter.hello() == :world
  end
end
