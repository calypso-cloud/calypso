defmodule CalypsoWeb.Components.Core.Form.Error do
  use Phoenix.Component

  @doc """
  Generates a generic error message.
  """
  slot :inner_block, required: true

  def error(assigns) do
    ~H"""
    <div class="flex gap-3 mt-3 text-sm leading-6 text-rose-600">
      <Heroicons.icon name="exclamation-circle" class="mt-0.5 h-5 w-5 flex-none" />
      <p>{render_slot(@inner_block)}</p>
    </div>
    """
  end
end
