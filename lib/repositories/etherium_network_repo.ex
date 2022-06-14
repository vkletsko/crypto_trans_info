defmodule EtheriumNetworkRepo do
  @moduledoc false

  require Logger
  use Etherscan.Constants
  alias CryptoTransInfo.Transactions.Transaction


  def get_transaction_by_hash(tx_hash) do
    with  {:ok, tx_data} <- safe_get_tx_by_hash(tx_hash),
          {:ok, block_num} <- safe_get_block_number(),
          {:ok, tx_attrs} <- Transaction.get_tx_data(tx_data, block_num)do

    {:ok, tx_attrs}
    else
      error -> wrap_error(error)
    end
  end

  defp safe_get_tx_by_hash(tx_hash) do
    try do
      Etherscan.eth_get_transaction_by_hash(tx_hash)
    rescue
      exception -> wrap_error({:errors, "get_tx_by_hash", exception})
    end
  end

  defp safe_get_block_number() do
    try do
      Etherscan.eth_block_number
    rescue
      exception -> wrap_error("get_block_number", exception)
    end
  end


  defp wrap_error({:errors, {code, msg}}) do
    Logger.error("getting etherscan api unknown error = #{msg}")
    {:error,
      %{"code" => code,
        "error" => %{
          "message" => msg,
        }
      }
    }
  end
  defp wrap_error(tag, exception) do
    Logger.error("getting etherscan api unknown error = #{inspect(exception)}")
    {:error,
      %{"code" => -2,
        "error" => %{
          "message" => "#{tag}: unknown_server_error",
        }
      }
    }
  end

end
