defmodule BankingApiWeb.V1.ReportView do
  use BankingApiWeb, :view
  alias BankingApiWeb.V1.TransactionView

  def render("report.json", %{transactions: transactions}) do
    %{
      today: render_many(transactions.today, TransactionView, "transaction.json"),
      month: transactions.month |> handle_groups(),
      year: transactions.year |> handle_groups()
    }
  end


  defp handle_groups(transactions) when transactions |> is_map do
    transactions
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      acc |> Map.merge(%{k => v |> handle_groups()})
    end)
  end

  defp handle_groups(transactions) when transactions |> is_list do
    transactions
    |> render_many(TransactionView, "transaction.json")
  end
end