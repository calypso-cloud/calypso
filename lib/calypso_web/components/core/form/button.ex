defmodule CalypsoWeb.Components.Core.Form.Button do
  use Phoenix.Component

  @variants %{
    "default" => "bg-black text-white shadow hover:bg-black/90",
    "destructive" => "bg-red text-red-foreground shadow-sm hover:bg-red/90",
    "outline" =>
      "border border-input bg-background shadow-sm hover:bg-accent hover:text-accent-foreground",
    "secondary" => "bg-secondary text-secondary-foreground shadow-sm hover:bg-secondary/80",
    "ghost" => "hover:bg-accent hover:text-accent-foreground",
    "link" => "text-black underline-offset-4 hover:underline"
  }

  @doc """
  Renders a button.

  ## Examples

      <.button>Send!</.button>
      <.button phx-click="go" class="ml-2">Send!</.button>
  """
  attr :type, :string, default: nil
  attr :class, :any, default: nil

  attr :variant, :string,
    values: ~w(default secondary destructive outline ghost link),
    default: "default",
    doc: "the button variant style"

  attr :size, :string, values: ~w(default sm lg icon), default: "default"
  attr :rest, :global, include: ~w(disabled form name value)

  slot :inner_block, required: true

  def button(assigns) do
    assigns =
      assigns
      |> assign(:variant_class, @variants[assigns.variant])

    ~H"""
    <button
      type={@type}
      class={
        TwMerge.merge([
          "phx-submit-loading:opacity-75 rounded-lg py-2 px-3 text-sm font-semibold leading-6",
          @variant_class,
          @class
        ])
      }
      {@rest}
    >
      {render_slot(@inner_block)}
    </button>
    """
  end
end
