defmodule ComicBookManagerWeb.SeriesLive.Index do
  use ComicBookManagerWeb, :live_view

  alias ComicBookManager.Comics
  alias ComicBookManager.Comics.Series

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :series_collection, list_series())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Series")
    |> assign(:series, Comics.get_series!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Series")
    |> assign(:series, %Series{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Series")
    |> assign(:series, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    series = Comics.get_series!(id)
    {:ok, _} = Comics.delete_series(series)

    {:noreply, assign(socket, :series_collection, list_series())}
  end

  defp list_series do
    Comics.list_series()
  end
end
