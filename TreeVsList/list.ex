defmodule Lst do

  #makes list of tuples
  def append(:nil, y) do y end #empty list
  def append({:cons, head, tail}, y) do #not empty list
    {:cons, head, append(tail, y)}
  end

  #add element to queue
  def add(queue, elem) do

  end

  #remove element from queue
  def remov(queue) do

  end

end
