defmodule CalypsoWeb.Components.Core.Feedback do
  defmacro __using__(_opts) do
    quote do
      import CalypsoWeb.Components.Core.Feedback.{
        Flash,
        Modal
      }
    end
  end
end
