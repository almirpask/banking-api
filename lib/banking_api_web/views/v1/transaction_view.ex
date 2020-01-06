defmodule BankingApiWeb.V1.TransactionView do
  use BankingApiWeb, :view
  alias BankingApiWeb.V1.TransactionHelper
  def render("transaction.json", %{transaction: transaction}) do
    if transaction |> Map.has_key?(:type) do
      TransactionHelper.format(transaction)
      |> Map.put(:type, transaction.type)
    else
      TransactionHelper.format(transaction)
    end
  end 
end