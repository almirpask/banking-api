defmodule BankingApiWeb.V1.ReportController do
  use BankingApiWeb, :controller
  alias BankingApi.Accounts
  alias BankingApi.Bank

  def index(conn, _params) do
    transactions = Bank.report()

    with true <- !(transactions.today |> is_nil),
         true <- !(transactions.month |> is_nil),
         true <- !(transactions.year |> is_nil) do
      conn
      |> render("report.json", transactions: transactions)
    end
  end
end