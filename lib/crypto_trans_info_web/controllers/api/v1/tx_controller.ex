defmodule CryptoTransInfoWeb.Api.V1.TxController do
  @moduledoc false

  require Logger
  use CryptoTransInfoWeb, :controller
  alias CryptoTransInfo.Transactions


  def show(conn, %{"id" => tx_hash}) do
    with {:ok, tx} <- Transactions.get_by_hash(tx_hash) do
      render(conn, "show.json", tx: tx)
      else
      {:error, errors} ->
        render(conn, "show_error.json", errors: errors)
    end
  end


end
