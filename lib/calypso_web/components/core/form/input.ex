defmodule CalypsoWeb.Components.Core.Form.Input do
  use Phoenix.Component

  alias CalypsoWeb.Components.Core

  @doc """
  Displays a form input field or a component that looks like an input field.

  ## Examples

      <.input type="text" placeholder="Enter your name" />
      <.input type="email" placeholder="Enter your email" />
      <.input type="password" placeholder="Enter your password" />
  """
  attr :field, Phoenix.HTML.FormField,
    doc: "a form field struct retrieved from the form, for example: @form[:email]"

  attr :id, :any, default: nil
  attr :name, :any, default: nil
  attr :value, :any, default: nil
  attr :class, :any, default: nil

  attr :errors, :list, default: []
  attr :disabled, :boolean, default: false

  attr :type, :string,
    default: "text",
    values:
      ~w(date datetime-local email file hidden month number password tel text time url week checkbox)

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns[:id] || field.id)
    |> assign(:errors, Enum.map(field.errors, &Core.translate_error(&1)))
    |> assign(
      :name,
      assigns[:name] || if(assigns[:multiple], do: field.name <> "[]", else: field.name)
    )
    |> assign(:value, assigns[:value] || field.value)
    |> input()
  end

  def input(%{type: "checkbox"} = assigns) do
    assigns =
      assign_new(assigns, :checked, fn ->
        Phoenix.HTML.Form.normalize_value("checkbox", assigns[:value])
      end)

    ~H"""
    <div class="contents">
      <input type="hidden" name={@name} value="false" disabled={@disabled} />
      <input
        type="checkbox"
        id={@id}
        name={@name}
        value="true"
        checked={@checked}
        class={
          TwMerge.merge([
            "rounded border-zinc-300 text-zinc-900 focus-visible:outline-none",
            "focus-visible:ring-blue-600 focus-visible:ring-2 focus-visible:ring-offset-2"
          ])
        }
        {@rest}
      />
    </div>
    """
  end

  def input(%{type: "datetime-local"} = assigns) do
    ~H"""
    <input
      id={@id}
      name={@name}
      value={Phoenix.HTML.Form.normalize_value("datetime-local", @value)}
      type={@type}
      class={
        TwMerge.merge([
          "flex h-10 w-full rounded-md border px-3 py-2 text-sm",
          "focus-visible:outline-none focus-visible:ring-blue-600 focus-visible:ring-2 focus-visible:ring-offset-2",
          "disabled:cursor-not-allowed disabled:opacity-50",
          @errors == [] && "border-zinc-300 focus:border-zinc-400",
          @errors != [] && "border-rose-400 focus:border-rose-400",
          @class
        ])
      }
      {@rest}
    />
    """
  end

  def input(assigns) do
    ~H"""
    <input
      id={@id}
      name={@name}
      value={@value}
      type={@type}
      class={
        TwMerge.merge([
          "flex h-10 w-full rounded-md border px-3 py-2 text-sm",
          "focus-visible:outline-none focus-visible:ring-blue-600 focus-visible:ring-2 focus-visible:ring-offset-2",
          "disabled:cursor-not-allowed disabled:opacity-50",
          @errors == [] && "border-zinc-300 focus:border-zinc-400",
          @errors != [] && "border-rose-400 focus:border-rose-400",
          @class
        ])
      }
      {@rest}
    />
    """
  end
end
