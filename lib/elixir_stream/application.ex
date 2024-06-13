defmodule ElixirStream.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirStream.Repo,
      {DNSCluster, query: Application.get_env(:elixir_stream, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ElixirStream.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ElixirStream.Finch},
      # Start a worker by calling: ElixirStream.Worker.start_link(arg)
      # {ElixirStream.Worker, arg},
      # Start to serve requests, typically the last entry
      ElixirStreamWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirStream.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ElixirStreamWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
