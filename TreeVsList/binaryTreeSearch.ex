defmodule Tree do

  #node representaion -> {:node, element, rightleaf, leftleaf}

  #UNORDERED TREE
  #search for a given number, returns yes if exist, no if not
  def searchs(_, nil) do :no end #empty tree
  def searchs(elem, {:leaf}, elem) do :yes end
  def searchs(_, {:leaf, _}) do :no end
  def searchs(elem, {:node, elem, _, _}) do :yes end
  def searchs(elem, {:node, _, left, right}) do
    case search(elem, left) do
      :yes -> :yes
      :no -> case search(elem, right) do
        :yes -> :yes
        :no -> :no
      end
    end
  end

  #ORDERED TREE
  #search for a given number, returns yes if exist, no if not
  def search(_, nil) do :no end #empty tree
  def search(elem, {:leaf}, elem) do :yes end
  def search(_, {:leaf, _}) do :no end
  def search(elem, {:node, elem, _, _}) do :yes end
  def search(elem, {:node, e, left, right}) do
    if elem < e do
      search(elem, left)
    else
      search(elem, right) do
      end
    end
  end

end
