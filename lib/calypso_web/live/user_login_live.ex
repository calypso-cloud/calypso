defmodule CalypsoWeb.UserLoginLive do
  use CalypsoWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="max-w-sm mx-auto">
      <.header class="text-center">
        Log in to account
        <:subtitle>
          Don't have an account?
          <.link navigate={~p"/users/register"} class="font-semibold text-brand hover:underline">
            Sign up
          </.link>
          for an account now.
        </:subtitle>
      </.header>
      
      <.simple_form for={@form} id="login_form" action={~p"/users/log_in"} phx-update="ignore">
        <.form_field :let={f} field={@form[:email]}>
          <.label field={f}>Email</.label>
           <.input field={f} type="email" required />
        </.form_field>
        
        <.form_field :let={f} field={@form[:password]}>
          <.label field={f}>Password</.label>
           <.input field={f} type="password" required />
        </.form_field>
        
        <:actions>
          <.form_field :let={f} field={@form[:remember_me]} class="flex-row-reverse items-center">
            <.label field={f}>Keep me logged in</.label>
             <.input field={f} type="checkbox" />
          </.form_field>
          
          <.link href={~p"/users/reset_password"} class="text-sm font-semibold">
            Forgot your password?
          </.link>
        </:actions>
        
        <:actions>
          <.button phx-disable-with="Logging in..." class="w-full">
            Log in <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
