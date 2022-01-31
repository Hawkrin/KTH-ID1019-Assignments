defmodule Queu do

  ######Creates and manipulate queue with bad BigO######

  #create a queue in the form of a list
  def newBad() do [] end

  #add element to queue
  def addBad([], elem) do [elem] end
  def addBad([h|t], elem) do
    [h| add(t, elem)]
  end

  #remove element from queue
  def removeBad([]) do :error end
  def removeBad([elem|rest]) do {:ok, elem, rest} end



  ######Creates and manipulate queue with good BigO######

  #create a queue in the form of a list
  def new() do {:queu, [], []} end

  #add element to queue
  def add({:queu, front, back}, elem) do {:queu, front, [elem|back]} end

  #remove element from queue
  def remove({:queu, [], []}) do :error  end
  def remove({:queu, [], back}) do remove({:queu, reverse(back), []}) end
  def remove({:queu, [elem|rest], back}) do {:ok, elem, {:queu, rest, back}} end

  def reverse(lst) do reverse(lst, []) end
  def reverse([], rev) do rev end
  def reverse([h|t], rev) do reverse(t, [h|rev]) end

end
