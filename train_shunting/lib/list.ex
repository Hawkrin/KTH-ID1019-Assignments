defmodule ListOperations do
    def take(xs, n) do
        Enum.take(xs, n)
    end
    def drop(xs, n) do
        xs -- Enum.take(xs, n)
    end
    def append(xs, ys) do
        xs ++ ys
    end
    def member(xs, y) do
        y in xs
    end
    def position(xs, y) do
        position(xs, y, 1)
    end
    def position(xs, y, counter) do
        if(hd(xs) == y) do
            counter
        else
            position(tl(xs), y, (counter+1))
        end
    end
end
#
