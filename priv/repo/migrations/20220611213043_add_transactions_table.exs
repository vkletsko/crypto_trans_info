defmodule Transactions.Repo.Migrations.AddTransactionstable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :hash, :string, size: 64
      add :block_hash, :string, size: 64
      add :block_confirmations, :integer
      add :block_number, :integer
      add :status, :string, size: 10, null: false, default: "fail"
      add :from, :string, size: 20
      add :to, :string, size: 20
      add :gas, :integer
      add :gas_price, :string, size: 32
      add :input, :text
      add :nonce, :integer
      add :r, :string, size: 32
      add :s, :string, size: 32
      add :transaction_index, :integer
      add :v, :string, size: 1
      add :value, :string, size: 32

      timestamps()

    end

    create index(:transactions, [:hash])
    create index(:transactions, [:from])
    create index(:transactions, [:to])
    create index(:transactions, [:status])

  end

end
