defmodule ComicBookManagerWeb.UniverseLive.Index do
  use ComicBookManagerWeb, :live_view

  alias ComicBookManager.Comics
  alias ComicBookManager.Comics.Universe

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :universes, list_universes())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Universe")
    |> assign(:universe, Comics.get_universe!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Universe")
    |> assign(:universe, %Universe{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Universes")
    |> assign(:universe, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    universe = Comics.get_universe!(id)
    {:ok, _} = Comics.delete_universe(universe)

    {:noreply, assign(socket, :universes, list_universes())}
  end

  defp list_universes do
    Comics.list_universes()
  end
end
