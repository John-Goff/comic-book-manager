defmodule ComicBookManagerWeb.ComicLive.FormComponent do
  use ComicBookManagerWeb, :live_component

  alias ComicBookManager.Comics

  @impl true
  def update(%{comic: comic} = assigns, socket) do
    changeset = Comics.change_comic(comic)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"comic" => comic_params}, socket) do
    changeset =
      socket.assigns.comic
      |> Comics.change_comic(comic_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"comic" => comic_params}, socket) do
    save_comic(socket, socket.assigns.action, comic_params)
  end

  defp save_comic(socket, :edit, comic_params) do
    case Comics.update_comic(socket.assigns.comic, comic_params) do
      {:ok, _comic} ->
        {:noreply,
         socket
         |> put_flash(:info, "Comic updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_comic(socket, :new, comic_params) do
    case Comics.create_comic(comic_params) do
      {:ok, _comic} ->
        {:noreply,
         socket
         |> put_flash(:info, "Comic created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
