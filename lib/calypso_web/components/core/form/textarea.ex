defmodule CalypsoWeb.Components.Core.Form.TextArea do
  use Phoenix.Component

  alias CalypsoWeb.Components.Core

  @doc """
  Displays a textarea input field.

  ## Examples

      <.texarea placeholder="Enter your message" />
  """
  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :id, :any, default: nil
  attr :name, :any, default: nil
  attr :value, :any, default: nil

  attr :errors, :list, default: []
  attr :class, :any, default: nil

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  def textarea(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns[:id] || field.id)
    |> assign(:errors, Enum.map(field.errors, &Core.translate_error(&1)))
    |> assign(
      :name,
      assigns[:name] || if(assigns[:multiple], do: field.name <> "[]", else: field.name)
    )
    |> assign(:value, assigns[:value] || field.value)
    |> textarea()
  end

  def textarea(assigns) do
    ~H"""
    <textarea
      id={@id}
      name={@name}
      class={[
        "relative w-full rounded-md text-zinc-900 p-3 text-sm sm:leading-6 min-h-28",
        "focus-visible:outline-none focus-visible:ring-blue-600 focus-visible:ring-2 focus-visible:ring-offset-2",
        @errors == [] && "border-zinc-300 focus:border-zinc-400",
        @errors != [] && "border-rose-400 focus:border-rose-400"
      ]}
      {@rest}
    >{Phoenix.HTML.Form.normalize_value("textarea", @value)}</textarea>
    """
  end
end
