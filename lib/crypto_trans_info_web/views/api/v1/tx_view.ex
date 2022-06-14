defmodule CryptoTransInfoWeb.Api.V1.TxView do
  @moduledoc false

  require Logger
  use CryptoTransInfoWeb, :view
  alias CryptoTransInfo.Transactions.Transaction

  def render("show.json", %{tx: %Transaction{
    hash: hash,
    block_number: block_num,
    block_confirmations: confirms,
    status: status,
    from: from,
    to: to,
    value: value,
    gas: gas,
    gas_price: gas_price

    }}) do
    %{code: 0,
      errors: %{},
      data:  %{
        hash: hash,
        block_number: block_num,
        block_confirmations: confirms,
        status: status,
        from: from,
        to: to,
        value: value,
        gas_price: gas_price,
        gas: gas
      }
    }
  end
  def render("show_error.json", %{errors: errors}) do
    errors
  end

end
