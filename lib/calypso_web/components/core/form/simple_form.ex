defmodule CalypsoWeb.Components.Core.Form.SimpleForm do
  use Phoenix.Component

  @doc """
  Renders a simple form.

  ## Examples

      <.simple_form for={@form} phx-change="validate" phx-submit="save">
        <.input field={@form[:email]} label="Email"/>
        <.input field={@form[:username]} label="Username" />
        <:actions>
          <.button>Save</.button>
        </:actions>
      </.simple_form>
  """
  attr :for, :any, required: true, doc: "the data structure for the form"
  attr :as, :any, default: nil, doc: "the server side parameter to collect all input under"

  attr :rest, :global,
    include: ~w(autocomplete name rel action enctype method novalidate target multipart),
    doc: "the arbitrary HTML attributes to apply to the form tag"

  slot :inner_block, required: true
  slot :actions, doc: "the slot for form actions, such as a submit button"

  def simple_form(assigns) do
    ~H"""
    <.form :let={f} for={@for} as={@as} {@rest}>
      <div class="relative flex flex-col items-start w-full gap-5">
        {render_slot(@inner_block, f)}
        <div
          :for={action <- @actions}
          class="relative flex items-center justify-between w-full gap-6 mt-2"
        >
          {render_slot(action, f)}
        </div>
      </div>
    </.form>
    """
  end
end
