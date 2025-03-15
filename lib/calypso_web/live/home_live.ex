defmodule CalypsoWeb.HomeLive do
  use CalypsoWeb, :live_view

  alias Phoenix.LiveView.Socket
  alias Calypso.Contexts.Task

  @type set_date_action() :: :yesterday | :today | :tomorrow

  def mount(_params, _session, socket) do
    socket =
      socket
      |> set_date(:today, DateTime.utc_now())
      |> load_tasks()

    {:ok, socket}
  end

  def handle_event("change_date", %{"action" => action}, socket) do
    socket =
      socket
      |> set_date(String.to_atom(action), socket.assigns.date)
      |> load_tasks()

    {:noreply, socket}
  end

  def handle_params(%{"id" => id}, _uri, socket) do
    socket =
      socket
      |> assign(:task_id, id)

    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket) do
    socket =
      socket
      |> assign(:task_id, nil)

    {:noreply, socket}
  end

  def handle_info(:reload_tasks, socket) do
    socket =
      socket
      |> load_tasks()

    {:noreply, socket}
  end

  @spec set_date(socket :: Socket.t(), action :: set_date_action(), date :: %DateTime{}) ::
          Socket.t()
  defp set_date(socket, action, date) do
    modifier =
      case action do
        :yesterday -> -1
        :today -> 0
        :tomorrow -> 1
      end

    socket
    |> assign(:date, DateTime.add(date, modifier, :day))
  end

  defp load_tasks(socket) do
    socket
    |> assign(:tasks, Task.get_by_date(socket.assigns.date))
  end
end
