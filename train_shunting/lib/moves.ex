defmodule Moves do
    #Flytta ingenting till main är samma som ursprungliga main.
    def single({_, 0}, state) do state end

    #Från main till one eller two.
    def single({_, n}, state={[],_,_}) when n>0 do state end #vad för move vi ska göra och vilken state vi befinner oss i
    def single({:one, n}, state) when n>0 do
        new = ListOperations.drop(elem(state, 0), (Enum.count(elem(state, 0))-n)) # new list
        {elem(state, 0) -- new, new ++ elem(state, 1), elem(state, 2)} #ta bort från main - > lägg in i en annan lista
    end
    def single({:two, n}, state) when n>0 do
        new = ListOperations.drop(elem(state, 0), (Enum.count(elem(state, 0))-n))
        {elem(state, 0) -- new, elem(state, 1), new ++ elem(state, 2)}
    end

    #Flytta från one eller two till main.
    def single({:one, n}, state={_,[],_}) when n<0 do state end
    def single({:one, n}, state) when n<0 do
        new = ListOperations.take(elem(state, 1), -n)
        {new ++ elem(state, 0), elem(state, 1) -- new, elem(state, 2)}
    end
    def single({:two, n}, state={_,_,[]}) when n<0 do state end
    def single({:two, n}, state) when n<0 do
        new = ListOperations.take(elem(state, 2), -n)
        {new ++ elem(state, 0), elem(state, 1), elem(state, 2) -- new}
    end

    #single -> sätt vi kan flytta på vagnar
    # om 1 main -> (1/2)
    # om -1 (1/2) -> main



    #Hantera lista av instruktioner.
    def move(moves=[_|_], state) do #tar lista av moves och anropar single
        move(moves, state, [state])
    end
    def move([], _state, states=[_|_]) do states end
    def move(moves=[_|_], state, states=[_|_]) do
        state = single(hd(moves), state)
        states = states ++ [state]
        move(tl(moves), state, states)
    end

end
