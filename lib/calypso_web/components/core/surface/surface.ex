defmodule CalypsoWeb.Components.Core.Surface do
  defmacro __using__(_opts) do
    quote do
      import CalypsoWeb.Components.Core.Surface.{
        Card
      }
    end
  end
end
