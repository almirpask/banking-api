defmodule BankingApi.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Accounts.Credential
  schema "users" do
    field :" name", :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 1)
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast_assoc(:credential, with: &Credential.changeset/2, required: true)
  end
end
