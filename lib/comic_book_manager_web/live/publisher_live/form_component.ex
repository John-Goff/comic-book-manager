defmodule ComicBookManagerWeb.PublisherLive.FormComponent do
  use ComicBookManagerWeb, :live_component

  alias ComicBookManager.Comics

  @impl true
  def update(%{publisher: publisher} = assigns, socket) do
    changeset = Comics.change_publisher(publisher)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"publisher" => publisher_params}, socket) do
    changeset =
      socket.assigns.publisher
      |> Comics.change_publisher(publisher_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"publisher" => publisher_params}, socket) do
    save_publisher(socket, socket.assigns.action, publisher_params)
  end

  defp save_publisher(socket, :edit, publisher_params) do
    case Comics.update_publisher(socket.assigns.publisher, publisher_params) do
      {:ok, _publisher} ->
        {:noreply,
         socket
         |> put_flash(:info, "Publisher updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_publisher(socket, :new, publisher_params) do
    case Comics.create_publisher(publisher_params) do
      {:ok, _publisher} ->
        {:noreply,
         socket
         |> put_flash(:info, "Publisher created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
