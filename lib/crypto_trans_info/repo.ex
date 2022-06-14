defmodule CryptoTransInfo.Repo do
  use Ecto.Repo,
    otp_app: :crypto_trans_info,
    adapter: Ecto.Adapters.SQLite3

end
