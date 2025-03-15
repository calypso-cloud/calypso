defmodule CalypsoWeb.HomeLive.EditTaskForm do
  use CalypsoWeb, :live_component

  alias Calypso.Contexts
  alias Calypso.Models.Task

  @priorities [
    {"Low", :low},
    {"Medium", :medium},
    {"High", :high},
    {"Urgent", :urgent}
  ]

  def mount(socket) do
    {:ok, socket}
  end

  def update(%{task_id: task_id}, socket) do
    init = Contexts.Task.get(task_id)

    form =
      init
      |> Task.changeset()
      |> to_form()

    socket =
      socket
      |> assign(:init, init)
      |> assign(:form, form)
      |> assign(:priorities, @priorities)

    {:ok, socket}
  end

  def handle_event("validate", %{"task" => params}, socket) do
    form =
      socket.assigns.init
      |> Task.apply_changeset(params)
      |> to_form(action: :validate)

    socket =
      socket
      |> assign(:form, form)

    {:noreply, socket}
  end

  def handle_event("update", %{"task" => params}, socket) do
    socket =
      with {:ok, _} <- Contexts.Task.update(socket.assigns.init, params) do
        send(self(), :reload_tasks)

        socket
        |> put_flash(:info, "Task updated successfully")
        |> push_patch(to: ~p"/")
      else
        {:error, changeset} ->
          socket
          |> assign(:form, to_form(changeset, action: :update))
      end

    {:noreply, socket}
  end

  def handle_event("delete", _params, socket) do
    socket =
      with {:ok, _} <- Contexts.Task.delete(socket.assigns.init) do
        send(self(), :reload_tasks)

        socket
        |> put_flash(:info, "Task deleted successfully")
        |> push_patch(to: ~p"/")
      else
        {:error, changeset} ->
          socket
          |> assign(:form, to_form(changeset, action: :delete))
      end

    {:noreply, socket}
  end
end
