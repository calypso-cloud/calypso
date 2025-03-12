defmodule CalypsoWeb.HomeLive.NewTaskForm do
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

  def update(_assigns, socket) do
    init = %Task{
      categories: [],
      start_date: default_start_date(),
      end_date: default_end_date()
    }

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

  def handle_event("create", %{"task" => params}, socket) do
    socket =
      with {:ok, _} <- Contexts.Task.create(socket.assigns.init, params) do
        send(self(), :reload_tasks)

        socket
        |> put_flash(:info, "Task created successfully")
        |> push_patch(to: ~p"/")
      else
        {:error, changeset} ->
          socket
          |> assign(:form, to_form(changeset, action: :create))
      end

    {:noreply, socket}
  end

  defp default_start_date() do
    Date.utc_today() |> NaiveDateTime.new!(~T[12:00:00])
  end

  defp default_end_date() do
    Date.utc_today() |> NaiveDateTime.new!(~T[13:00:00])
  end
end
