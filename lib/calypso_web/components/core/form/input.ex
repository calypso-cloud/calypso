defmodule CalypsoWeb.Components.Core.Form.Input do
  use Phoenix.Component

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

  attr :type, :string,
    default: "text",
    values:
      ~w(date datetime-local email file hidden month number password tel text time url week checkbox)

  attr :rest, :global,
    include: ~w(accept autocomplete capture cols disabled form list max maxlength min minlength
                multiple pattern placeholder readonly required rows size step)

  def input(%{field: %Phoenix.HTML.FormField{} = field} = assigns) do
    assigns
    |> assign(field: nil, id: assigns[:id] || field.id)
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
      <input type="hidden" name={@name} value="false" disabled={@rest[:disabled]} />
      <input
        type="checkbox"
        id={@id}
        name={@name}
        value="true"
        checked={@checked}
        class="rounded border-zinc-300 text-zinc-900 focus:ring-0"
        {@rest}
      />
    </div>
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
          "flex h-10 w-full rounded-md border border-input bg-background px-3 py-2 text-sm ring-offset-background",
          "file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground",
          "focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2",
          "disabled:cursor-not-allowed disabled:opacity-50",
          @class
        ])
      }
      {@rest}
    />
    """
  end
end
