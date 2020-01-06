defmodule BankingApiWeb.V1.TransferController do
  use BankingApiWeb, :controller
  alias BankingApi.Accounts
  alias BankingApi.Bank

  def create(conn, %{"amount" => amount, "user_id" => user_id}) do
    {:ok, current_user} = conn.assigns.current_user
    with {:ok, receiving_user} <- user_id |> Accounts.get_user!(),
         {:ok, %{from_transaction: from_transaction, to_transaction: to_transaction}} <-
          current_user |> Bank.transfer(receiving_user, Money.new(amount)) do
      conn
      |> json(%{from_transaction: from_transaction, to_transaction: to_transaction})
    else
      _ ->
        json(conn, %{error: "transaction fail"})
    end
  end
end