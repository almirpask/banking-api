defmodule BankingApiWeb.V1.WithdrawController do
  use BankingApiWeb, :controller
  alias BankingApi.Bank

  def create(conn, %{"amount" => amount}) do
    {:ok , current_user} = conn.assigns.current_user    
    with {:ok, user, transaction} <- current_user |> Bank.withdraw(Money.new(amount)) do
      render(conn,"transaction.json",
        transaction: %{
          user_id: user.id,
          amount: transaction.amount,
          transaction_id: transaction.id,
          type: "withdrawal",
          date: transaction.inserted_at
        }
      )
    end 
  end
end