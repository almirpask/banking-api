defmodule BankingApiWeb.V1.TransferView do
  use BankingApiWeb, :view
  alias BankingApiWeb.V1.TransactionView

  def render("transfer.json", %{type: type, from_transaction: from_transaction, to_transaction: to_transaction}) do
    %{
      transactions: [
        render_one(from_transaction |> Map.put(:type, type), TransactionView, "transaction.json"),
        render_one(to_transaction |> Map.put(:type, type), TransactionView, "transaction.json")
      ]
    }
  end
end