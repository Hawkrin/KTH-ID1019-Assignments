defmodule Emulator do

  def run(prgm) do
    {code, data} = Program.load(prgm)
    reg = Register.new()
    run(0, code, reg, data)
  end

  def run(pc, code, reg, mem) do
    next = Program.read_instruction(code, pc)
    case next do
    :halt ->
      :ok

  {:add, rd, rs, rt} ->
    pc = pc + 4
    s = Register.read(reg, rs)
    t = Register.read(reg, rt)
    reg = Register.write(reg, rd, s + t) # well, almost
    run(pc, code, reg, mem)
  :
  end
end
