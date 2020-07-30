defmodule BrodSample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # Work as intented, on fail it stops completly
    BrodSample.GroupSubscriber.start()

    # BrodSample.GroupSubscriberV2.start() Doesn't work, issue opened

    children = [
      # Starts a worker by calling: BrodSample.Worker.start_link(arg)
      # {BrodSample.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BrodSample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
