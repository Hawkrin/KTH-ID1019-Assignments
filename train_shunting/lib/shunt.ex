defmodule Shunt do
    #xs - current train | ys - desired train.
    def find(xs, ys) do find(xs, ys, []) end #xs -> current state , ys -> future state, [] -> list of moves
    #def find(_xs=[_|], _ys, moves) do moves end
    def find(_xs, _ys=[], moves) do moves end
    def find(xs, ys, moves) do
        split_xs = split(xs, hd(ys))
        hs = elem(split_xs, 0)
        ts = elem(split_xs, 1)

        moves= moves ++ [{:one,Enum.count(ts)+1}, {:two,Enum.count(hs)}, {:one,-(Enum.count(ts)+1)}, {:two,-(Enum.count(hs))}]

        find(tl(xs), tl(ys), moves)
    end
    def split(xs=[_|_], y) do
        index = ListOperations.position(xs,y)
        hs = ListOperations.take(xs, index-1)
        ts = ListOperations.drop(xs, index)
        {hs, ts}
    end

end
