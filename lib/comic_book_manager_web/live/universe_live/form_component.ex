defmodule ComicBookManagerWeb.UniverseLive.FormComponent do
  use ComicBookManagerWeb, :live_component

  alias ComicBookManager.Comics

  @impl true
  def update(%{universe: universe} = assigns, socket) do
    changeset = Comics.change_universe(universe)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"universe" => universe_params}, socket) do
    changeset =
      socket.assigns.universe
      |> Comics.change_universe(universe_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"universe" => universe_params}, socket) do
    save_universe(socket, socket.assigns.action, universe_params)
  end

  defp save_universe(socket, :edit, universe_params) do
    case Comics.update_universe(socket.assigns.universe, universe_params) do
      {:ok, _universe} ->
        {:noreply,
         socket
         |> put_flash(:info, "Universe updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_universe(socket, :new, universe_params) do
    case Comics.create_universe(universe_params) do
      {:ok, _universe} ->
        {:noreply,
         socket
         |> put_flash(:info, "Universe created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
