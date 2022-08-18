defmodule ComicBookManagerWeb.UniverseLive.Show do
  use ComicBookManagerWeb, :live_view

  alias ComicBookManager.Comics

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:universe, Comics.get_universe!(id))}
  end

  defp page_title(:show), do: "Show Universe"
  defp page_title(:edit), do: "Edit Universe"
end
