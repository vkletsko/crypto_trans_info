defmodule CryptoTransInfoWeb.WebAppController do
  use CryptoTransInfoWeb, :controller

  def index(conn, _params) do
    conn
    |> send_resp(200, render_react_app())
  end

#  @todo
  defp render_react_app() do
    Application.app_dir(:crypto_trans_info, "priv/static/www/index.html")
    |> File.read!()
  end
  
end
