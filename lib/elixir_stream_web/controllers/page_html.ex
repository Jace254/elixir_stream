defmodule ElixirStreamWeb.PageHTML do
  use ElixirStreamWeb, :html

  def home(assigns) do
    ~H"""
    <div class="flex items-center flex-col w-full">
      <h2 class="text-xl font-bold"><%= gettext "Welcome to %{name}!", name: "Phoenix" %></h2>
      <p class="font-thin text-lg">A productive web framework that does not compromise speed and maintainability.</p>
    </div>

    <div class="py-4 flex flex-col items-start gap-4">
      <div class="flex flex-col">
        <h4 class="font-bold text-lg">Resources</h4>
        <ul class="flex flex-col ml-4">
          <li>
            <a href="http://phoenixframework.org/docs/overview">Guides</a>
          </li>
          <li>
            <a href="https://hexdocs.pm/phoenix">Docs</a>
          </li>
          <li>
            <a href="https://github.com/phoenixframework/phoenix">Source</a>
          </li>
        </ul>
      </div>

      <div class="flex flex-col">
        <h4 class="font-bold text-lg">Help</h4>
        <ul class="flex flex-col ml-4">
          <li>
            <a href="http://groups.google.com/group/phoenix-talk">Mailing list</a>
          </li>
          <li>
            <a href="http://webchat.freenode.net/?channels=elixir-lang">#elixir-lang on freenode IRC</a>
          </li>
          <li>
            <a href="https://twitter.com/elixirphoenix">@elixirphoenix</a>
          </li>
        </ul>
      </div>
    </div>
    """
  end

end
