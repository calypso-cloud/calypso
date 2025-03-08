defmodule Calypso.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CalypsoWeb.Telemetry,
      Calypso.Repo,
      {DNSCluster, query: Application.get_env(:calypso, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Calypso.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Calypso.Finch},
      # Start a worker by calling: Calypso.Worker.start_link(arg)
      # {Calypso.Worker, arg},
      # Start to serve requests, typically the last entry
      CalypsoWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Calypso.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    CalypsoWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
