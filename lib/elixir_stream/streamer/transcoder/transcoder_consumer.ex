defmodule ElixirStream.TranscoderConsumer do
  use ConsumerSupervisor

  def start_link() do
    ConsumerSupervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [worker(ElixirStream.Transcoder, [], restart: :temporary)]
    {:ok,
      children,
      strategy: :one_for_one,
      subscribe_to: [{ElixirStream.TranscoderProducer, max_demand: 2}]}
  end
end
