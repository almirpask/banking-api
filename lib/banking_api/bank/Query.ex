defmodule BankingApi.Bank.Query do
  @moduledoc """
  Custom queries for Bank context 
  """
  import Ecto.Query

  alias BankingApi.Accounts.User
  alias BankingApi.Bank.Transaction

  @now Timex.now()

  def list_accounts_preloaded do
    from users in User,
      preload: [:credential, :balance]
  end

  def get_all_transactions_today do
    today = @now |> Timex.to_date()

    from transactions in Transaction,
      where: fragment("date(inserted_at) = ?", ^today)
  end

  def get_all_transactions_month do
    {beginning_date, end_date} = get_range_month()

    from transactions in Transaction,
      where: fragment("date(inserted_at) between ? and ?", ^beginning_date, ^end_date)
  end

  def get_all_transactions_year do
    {beginning_date, end_date} = get_range_year()

    from transactions in Transaction,
      where: fragment("date(inserted_at) between ? and ?", ^beginning_date, ^end_date)
  end

  def get_range_month do
    beginning_of_month = @now |> Timex.beginning_of_month() |> Timex.to_date()
    end_of_month = @now |> Timex.end_of_month() |> Timex.to_date()
    {beginning_of_month, end_of_month}
  end

  def get_range_year do
    beginning_of_year = @now |> Timex.beginning_of_year() |> Timex.to_date()
    end_of_year = @now |> Timex.end_of_year() |> Timex.to_date()
    {beginning_of_year, end_of_year}
  end
end