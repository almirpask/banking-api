defmodule BankingApi.Mailer do
  alias BankingApi.Accounts.User
  alias BankingApi.Bank.Transaction

  def withdraw(%User{} = user, %Transaction{} = transaction) do
    IO.puts("Withdrawal completed!")
    IO.puts("from: noreply@banking.com, to: #{user.credential.email}")
    IO.puts("Hi #{user.name} a withdrawal of #{transaction.amount} was successful")
  end
end