defmodule BankingApi.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:transactions, [:user_id])
  end
end
