defmodule CryptoTransInfo.Transactions do
  @moduledoc """
    Repo Transactions
  """

  require Logger
  import Ecto.Query, warn: false

  alias CryptoTransInfo.Repo
  alias CryptoTransInfo.Transactions.Transaction


  @spec get_by_hash(binary()) :: {:ok, %Transaction{}} | {:ok, map()} | {:error, map()} | {:error, any()}
  def get_by_hash(tx_hash) do
    case tx_get_by_hash(tx_hash) do
      %Transaction{} = tx ->
        Logger.debug("got transaction by id = #{inspect(tx)}")
        {:ok, tx}
      nil ->
        case EtheriumNetworkRepo.get_transaction_by_hash(tx_hash) do
          {:ok, tx_attrs} ->
            Logger.debug("success got transaction from web ethers = #{inspect(tx_attrs)}")
            tx_insert(tx_attrs)
          err -> err
        end
      any ->
        Logger.debug("any case transactions by hash = #{inspect(any)}")
        any
    end

  end

  defp tx_get_by_hash(tx_hash) do
    from(t in Transaction, where: t.hash == ^tx_hash)
    |> Repo.one
  end

  defp tx_insert(tx_attrs) do
    %Transaction{}
    |> Transaction.changeset(tx_attrs)
    |> Repo.insert()
  end

end
