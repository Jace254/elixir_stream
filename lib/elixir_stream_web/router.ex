defmodule ElixirStreamWeb.Router do
  use ElixirStreamWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ElixirStreamWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ElixirStreamWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/slides", SlideController, :index
    post "/start_stream", SlideController, :start_stream
    post "/vote/:vote", SlideController, :vote
  end
end
