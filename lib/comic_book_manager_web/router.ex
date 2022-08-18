defmodule ComicBookManagerWeb.Router do
  use ComicBookManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ComicBookManagerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ComicBookManagerWeb do
    pipe_through :browser

    live "/", ComicLive.Index, :index
    live "/new", ComicLive.Index, :new
    live "/:id/edit", ComicLive.Index, :edit

    live "/:id", ComicLive.Show, :show
    live "/:id/show/edit", ComicLive.Show, :edit

    live "/series", SeriesLive.Index, :index
    live "/series/new", SeriesLive.Index, :new
    live "/series/:id/edit", SeriesLive.Index, :edit

    live "/series/:id", SeriesLive.Show, :show
    live "/series/:id/show/edit", SeriesLive.Show, :edit

    live "/publishers", PublisherLive.Index, :index
    live "/publishers/new", PublisherLive.Index, :new
    live "/publishers/:id/edit", PublisherLive.Index, :edit

    live "/publishers/:id", PublisherLive.Show, :show
    live "/publishers/:id/show/edit", PublisherLive.Show, :edit

    live "/universes", UniverseLive.Index, :index
    live "/universes/new", UniverseLive.Index, :new
    live "/universes/:id/edit", UniverseLive.Index, :edit

    live "/universes/:id", UniverseLive.Show, :show
    live "/universes/:id/show/edit", UniverseLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", ComicBookManagerWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ComicBookManagerWeb.Telemetry
    end
  end
end
