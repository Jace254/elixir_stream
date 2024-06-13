defmodule ElixirStreamWeb.SlideHTML do
  use ElixirStreamWeb, :html

  def slide(assigns) do
    ~H"""
    <div class="reveal">
      <div class="slides">
          <section>
            <iframe width="0" height="0" border="0" name="dummyframe" id="dummyframe"></iframe>
            <form action="/start_stream" method="post" target="dummyframe">
              <input type="submit" value="Start Stream!">
            </form>
            <form action="/vote/sis" method="post" target="dummyframe">
              <input type="submit" value="Vote Bruh!">
            </form>
            <form action="/vote/bruh" method="post" target="dummyframe">
              <input type="submit" value="Vote Sis!">
            </form>
          </section>
      </div>
    </div>
    """
  end
end
