defmodule ComicBookManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Desktop.identify_default_locale(ComicBookManagerWeb.Gettext)

    children = [
      # Start the Ecto repository
      ComicBookManager.Repo,
      # Start the Telemetry supervisor
      ComicBookManagerWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ComicBookManager.PubSub},
      # Start the Endpoint (http/https)
      ComicBookManagerWeb.Endpoint,
      # Start a worker by calling: ComicBookManager.Worker.start_link(arg)
      # {ComicBookManager.Worker, arg}
      {Desktop.Window,
       app: :comic_book_manager,
       id: ComicBookManagerWindow,
       url: &ComicBookManagerWeb.Endpoint.url/0}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ComicBookManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ComicBookManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
