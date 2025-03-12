defmodule CalypsoWeb.Components.Core.Form.FormField do
  use Phoenix.Component

  alias CalypsoWeb.Components.Core
  import CalypsoWeb.Components.Core.Form.Error

  @doc """
  A container for composing form fields.

  ## Examples

      <.input type="text" placeholder="Enter your name" />
      <.input type="email" placeholder="Enter your email" />
      <.input type="password" placeholder="Enter your password" />
  """

  attr :field, Phoenix.HTML.FormField,
    doc: "A form field struct retrieved from the form, for example: `@form[:email]`."

  attr :field_duplicate, Phoenix.HTML.FormField,
    doc: "Do not set. Used to pass the field as dynamic value for the inner_block."

  attr :errors, :list, default: []

  attr :id, :any, default: nil
  attr :name, :any, default: nil
  attr :value, :any
  attr :class, :any, default: nil

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  slot :inner_block do
  end

  def form_field(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns[:id] || field.id)
    |> assign(:errors, Enum.map(field.errors, &Core.translate_error(&1)))
    |> assign(
      :name,
      assigns[:name] || if(assigns[:multiple], do: field.name <> "[]", else: field.name)
    )
    |> assign(:value, assigns[:value] || field.value)
    |> assign(:field_duplicate, field)
    |> form_field()
  end

  def form_field(assigns) do
    ~H"""
    <div class={TwMerge.merge(["relative flex flex-col gap-[10px] items-start", @class])} {@rest}>
      {render_slot(@inner_block, @field_duplicate)}
      <.error :for={msg <- @errors}>{msg}</.error>
    </div>
    """
  end
end
