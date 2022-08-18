defmodule ComicBookManagerWeb.PublisherLive.Index do
  use ComicBookManagerWeb, :live_view

  alias ComicBookManager.Comics
  alias ComicBookManager.Comics.Publisher

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :publishers, list_publishers())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Publisher")
    |> assign(:publisher, Comics.get_publisher!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Publisher")
    |> assign(:publisher, %Publisher{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Publishers")
    |> assign(:publisher, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    publisher = Comics.get_publisher!(id)
    {:ok, _} = Comics.delete_publisher(publisher)

    {:noreply, assign(socket, :publishers, list_publishers())}
  end

  defp list_publishers do
    Comics.list_publishers()
  end
end
