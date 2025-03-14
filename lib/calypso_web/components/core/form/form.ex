defmodule CalypsoWeb.Components.Core.Form do
  defmacro __using__(_opts) do
    quote do
      import CalypsoWeb.Components.Core.Form.{
        Button,
        Error,
        FormField,
        Input,
        Label,
        Select,
        SimpleForm,
        TextArea
      }
    end
  end
end
