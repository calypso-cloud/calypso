defmodule CalypsoWeb.Components.Legacy do
  @moduledoc """
  These components are remnants of `core_components.ex` and don't have a suitable
  spot anywhere else.

  However, they are used enough to stay here until further notice.
  """

  use Phoenix.Component

  defmacro __using__(_opts) do
    quote do
      import CalypsoWeb.Components.Legacy
    end
  end

  @doc """
  Renders a header with title.
  """
  attr :class, :string, default: nil

  slot :inner_block, required: true
  slot :subtitle
  slot :actions

  def header(assigns) do
    ~H"""
    <header class={
      TwMerge.merge([@actions != [] && "flex items-center justify-between gap-6", @class])
    }>
      <div>
        <h1 class="text-lg font-semibold leading-8 text-zinc-800">{render_slot(@inner_block)}</h1>
        
        <p :if={@subtitle != []} class="mt-2 text-sm leading-6 text-zinc-600">
          {render_slot(@subtitle)}
        </p>
      </div>
      
      <div class="flex-none">{render_slot(@actions)}</div>
    </header>
    """
  end
end
