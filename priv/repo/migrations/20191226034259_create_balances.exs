defmodule BankingApi.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances) do
      add :amount, :decimal
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:balances, [:user_id])
  end
end
