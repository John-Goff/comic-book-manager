defmodule ComicBookManagerWeb.SeriesLive.FormComponent do
  use ComicBookManagerWeb, :live_component

  alias ComicBookManager.Comics

  @impl true
  def update(%{series: series} = assigns, socket) do
    changeset = Comics.change_series(series)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"series" => series_params}, socket) do
    changeset =
      socket.assigns.series
      |> Comics.change_series(series_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"series" => series_params}, socket) do
    save_series(socket, socket.assigns.action, series_params)
  end

  defp save_series(socket, :edit, series_params) do
    case Comics.update_series(socket.assigns.series, series_params) do
      {:ok, _series} ->
        {:noreply,
         socket
         |> put_flash(:info, "Series updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_series(socket, :new, series_params) do
    case Comics.create_series(series_params) do
      {:ok, _series} ->
        {:noreply,
         socket
         |> put_flash(:info, "Series created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
