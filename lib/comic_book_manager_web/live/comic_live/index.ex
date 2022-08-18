defmodule ComicBookManagerWeb.ComicLive.Index do
  use ComicBookManagerWeb, :live_view

  alias ComicBookManager.Comics
  alias ComicBookManager.Comics.Comic

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :comics, list_comics())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Comic")
    |> assign(:comic, Comics.get_comic!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Comic")
    |> assign(:comic, %Comic{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Comics")
    |> assign(:comic, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    comic = Comics.get_comic!(id)
    {:ok, _} = Comics.delete_comic(comic)

    {:noreply, assign(socket, :comics, list_comics())}
  end

  defp list_comics do
    Comics.list_comics()
  end
end
