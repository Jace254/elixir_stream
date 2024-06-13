defmodule ElixirStreamWeb.SlideController do
  use ElixirStreamWeb, :controller

  def index(conn, _params) do
    render conn, :index
  end

  def start_stream(conn, _params) do
    ElixirStream.VideoStreamer.start()
    render conn, :index
  end

  def vote(conn, %{"vote" => vote}) do
    ElixirStream.Voter.vote(vote)
    render conn, :index
  end
end
