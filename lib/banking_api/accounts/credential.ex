defmodule BankingApi.Accounts.Credential do
  use Ecto.Schema
  import Ecto.Changeset

  schema "credentials" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string    
    field :user_id, :id
    belongs_to :user, BankingApi.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(credential, attrs) do
    credential
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_lenght([:password, min: 6, max: 100])
    |> unique_constraint(:email)
  end
end
