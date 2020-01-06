defmodule BankingApiWeb.V1.WithdrawController do
  use BankingApiWeb, :controller
  alias BankingApi.Accounts
  alias BankingApi.Bank

  def create(conn, %{"amount" => amount}) do
    {:ok , current_user} = conn.assigns.current_user    
    with {:ok, user, transaction} <- current_user |> Bank.withdraw(Money.new(amount)) do
      json(conn, %{success: "sucess"})
    end 
  end
end