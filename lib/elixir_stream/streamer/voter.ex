defmodule ElixirStream.Voter do
  use GenServer

  def start_link(dir \\ "media/*") do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    {:ok, %{"Bruh" => 0, "Sis" => 0}}
  end

  def get_results, do: GenServer.call(__MODULE__, :get_results)

  def vote(vote), do: GenServer.cast(__MODULE__, {:vote, vote})

  def handle_call(:get_results, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:vote, vote}, state) do
    state = update_in(state[vote], &{&1 + 1})
    {:no_reply, state}
  end
end
