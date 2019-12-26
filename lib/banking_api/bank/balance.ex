defmodule BankingApi.Bank.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    field :amount, Money.Ecto.Amount.Type
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:amount, :user_id])
    |> validate_required([:user_id])
  end
end
