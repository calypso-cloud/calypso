defmodule CalypsoWeb.Components.Core.Form.Select do
  use Phoenix.Component

  alias CalypsoWeb.Components.Core

  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :id, :any, default: nil
  attr :name, :any
  attr :value, :any
  attr :class, :any, default: nil

  attr :prompt, :string, default: nil
  attr :options, :list, doc: "the options to pass to Phoenix.HTML.Form.options_for_select/2"
  attr :multiple, :boolean, default: false
  attr :errors, :list, default: []

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  def select(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns[:id] || field.id)
    |> assign(:errors, Enum.map(field.errors, &Core.translate_error(&1)))
    |> assign(
      :name,
      assigns[:name] || if(assigns[:multiple], do: field.name <> "[]", else: field.name)
    )
    |> assign(:value, assigns[:value] || field.value)
    |> select()
  end

  def select(assigns) do
    ~H"""
    <select
      id={@id}
      name={@name}
      class={
        TwMerge.merge([
          "relative w-full border border-gray-300 rounded-md text-sm",
          "focus-visible:outline-none focus-visible:ring-blue-600 focus-visible:ring-2 focus-visible:ring-offset-2",
          @errors == [] && "border-zinc-300 focus:border-zinc-400",
          @errors != [] && "border-rose-400 focus:border-rose-400",
          @class
        ])
      }
      multiple={@multiple}
      {@rest}
    >
      <option :if={@prompt} value="">{@prompt}</option>
       {Phoenix.HTML.Form.options_for_select(@options, @value)}
    </select>
    """
  end
end
