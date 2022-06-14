defmodule CryptoTransInfo.Transactions.Transaction do
  @typedoc """
      Type that represents Transaction struct
  """

  use Ecto.Schema
  use Etherscan.Constants

  import Ecto.Changeset
  alias CryptoTransInfo.{Transactions.Transaction}

  @success_block_confirms 2

  @cast_params [:hash, :block_hash, :block_confirmations, :block_number, :status,
    :input, :from, :gas, :gas_price, :input, :nonce,
    :r, :s, :to, :transaction_index, :v, :value]

  @required_params [:hash, :block_hash, :block_confirmations, :block_number,
    :status, :input, :from, :gas, :gas_price, :input,
    :nonce, :r, :s, :to, :transaction_index, :v, :value
  ]


  schema "transactions" do
    field :hash, :string
    field :block_hash, :string
    field :block_confirmations, :integer
    field :block_number, :integer
    field :status, :string, default: "fail"
    field :from, :string
    field :to, :string
    field :gas, :integer
    field :gas_price, :string
    field :input, :binary
    field :nonce, :integer
    field :r, :string
    field :s, :string
    field :transaction_index, :integer
    field :v, :string
    field :value, :string

    timestamps()
  end

  def changeset(%Transaction{} = tr, attrs) do
    tr
    |> cast(attrs, @cast_params)
    |> validate_required(@required_params)
  end

  @spec get_tx_data(%Etherscan.ProxyTransaction{} | map(), integer()) ::
          {:errors, {integer(), binary()}}
          | {:ok,
             %{
               block_confirmations: number,
               block_hash: any,
               block_number: number,
               from: any,
               gas: any,
               gas_price: any,
               hash: any,
               input: any,
               latest_block_number: number,
               nonce: any,
               r: any,
               s: any,
               status: <<_::32, _::_*24>>,
               to: any,
               transaction_index: any,
               v: any,
               value: any
             }}
  def get_tx_data(%Etherscan.ProxyTransaction{
    blockHash: block_hash,
    blockNumber: block_number,
    from: from,
    gas: gas,
    gasPrice: gas_price,
    hash: tx_hash,
    input: input,
    nonce: nonce,
    publicKey: nil,
    r: r,
    s: s,
    to: to,
    transactionIndex: tx_idx,
    v: v,
    value: value

  }, block_numbers) do
    init_attrs = %{
      hash: tx_hash,
      block_hash: block_hash,
      block_confirmations: 0,
      block_number: block_number,
      latest_block_number: block_numbers,
      status: "fail",
      input: input,
      from: from,
      gas: gas,
      gas_price: gas_price,
      nonce: nonce,
      r: r,
      s: s,
      to: to,
      transaction_index: tx_idx,
      v: v,
      value: value
    }

    attrs =
      init_attrs
      |> get_block_confirms
      |> resolve_status

    {:ok, attrs}

  end
  def get_tx_data(%{"code" => code, "message" => msg}, _block_numbers) do
    {:errors, {code, msg}}
  end
  def get_tx_data(_any, _block_numbers) do
    {:errors, {-1, "unknown_server_error"}}
  end


  defp get_block_confirms(%{
    block_number: block_num,
    latest_block_number: latest_block_num} = attrs) do
    # Number of transaction confirmations = latest block number-exchange
    tx_confirms = latest_block_num - block_num
    %{attrs| block_confirmations: tx_confirms}
  end

  defp resolve_status(%{block_confirmations: block_confirms} = attrs)
       when block_confirms >= @success_block_confirms do
    %{attrs| status: "success"}
  end
  defp resolve_status(attrs), do: attrs

end
