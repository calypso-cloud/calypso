defmodule CalypsoWeb.Components do
  defmacro __using__(_opts) do
    quote do
      use CalypsoWeb.Components.{
        Core,
        Legacy
      }
    end
  end
end
