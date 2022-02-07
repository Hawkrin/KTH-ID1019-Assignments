defmodule Eager do

  # if expression is an atom, retun the atom
  def eval_expr({:atm, id}, _, _) do {:ok, id} end

  # if expression is a variable, look up and return the variable, else return error
  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil ->
        :error
      {_, str} ->
        {:ok, str}
    end
  end

  # if expression is list/tuple go through its elements.
  def eval_expr({:cons, he, te}, env) do
    case eval_expr(he, env) do
      :error ->
        :error
      {:ok, hs } ->
        case eval_expr(te, env) do
          :error ->
            :error
          {:ok, ts} ->
            {:ok, {hs, ts}}
        end
    end
  end
end
