defmodule CryptoTransInfoWeb.PageController do
  use CryptoTransInfoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
