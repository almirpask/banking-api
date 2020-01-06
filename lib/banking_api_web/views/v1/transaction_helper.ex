defmodule BankingApiWeb.V1.TransactionHelper do
  def format(transaction) do
    %{
      transaction_id: transaction.transaction_id,
      user_id: transaction.user_id,
      amount: transaction.amount |> Money.to_string(),
      date: transaction.date
    }
  end
end