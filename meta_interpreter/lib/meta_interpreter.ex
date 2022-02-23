defmodule Eager do

  # if expression is an atom, return the atom
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

  # if expression is list/tuple go through its elements will return data structure, else return error
  def eval_expr({:cons, hx, tx}, env) do
    case eval_expr(hx, env) do
      :error ->
        :error
      {:ok, hs } ->
        case eval_expr(tx, env) do
          :error ->
            :error
          {:ok, ts} ->
            {:ok, {hs, ts}}
        end
    end
  end

  #Returns either {:ok, env}, where env is an extended environment, or the atom :fail.
  def eval_match(:ignore, _, env) do
    {:ok, env}
  end

  def eval_match({:atm, id}, id, env) do
    {:ok, env}
  end

  # If the left side is a vaitable we will evaluate it
  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      nil ->
        {:ok, Env.add(id, str, env)} #if the variable doesn't exist we add it
    {_, ^str} ->
        {:ok, env} #we return the environment if its the same structure as the right?
    {_, _} ->
      :fail # fail
    end
  end

  def eval_match({:cons, hp, tp}, ..., env) do
    case eval_match(..., ..., ...) do
      :fail ->
        ...
      ... ->
        eval_match(..., ..., ...)
    end
  end

  # If it's none of the above we fail it.
  def eval_match(_, _, _) do :fail end


end
