defmodule BankingApi.Bank.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    field :amount, :decimal
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:amount])
    |> validate_required([:amount])
  end
end
