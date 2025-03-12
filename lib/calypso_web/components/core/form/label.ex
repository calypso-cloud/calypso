defmodule CalypsoWeb.Components.Core.Form.Label do
  use Phoenix.Component

  @doc """
  Renders a label.
  """
  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :for, :string, default: nil
  slot :inner_block, required: true

  def label(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil)
    |> assign(for: assigns[:for] || field.id)
    |> label()
  end

  def label(assigns) do
    ~H"""
    <label for={@for} class="block text-sm font-semibold leading-6 text-zinc-800">
      {render_slot(@inner_block)}
    </label>
    """
  end
end
