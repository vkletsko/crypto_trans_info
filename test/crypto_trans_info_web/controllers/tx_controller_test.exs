defmodule CryptoTransInfoWeb.Api.V1.TxControllerTest do
  use CryptoTransInfoWeb.ConnCase

  test "success get transaction data by hash", %{conn: conn} do
    tx_hash = "0x7a3a1a72d8edbf8d25edde759d1142369397f8e1e69751f48f9dadfc0423993d"

    conn = get(conn, "/api/v1/tx/#{tx_hash}")

    response =
      conn
      |> json_response(200)

    assert %{"code" => 0, "data" => %{"hash" => ^tx_hash}} = response
  end

  test "fail invalid params", %{conn: conn} do
    tx_hash = "0x7a3a1"

    conn = get(conn, "/api/v1/tx/#{tx_hash}")

    response =
      conn
      |> json_response(200)

    assert %{ "code" => -32602,
              "error" => %{
                "message" => "invalid argument 0: json: cannot unmarshal hex string of odd length into Go value of type common.Hash"
                }
            } = response
  end



end
