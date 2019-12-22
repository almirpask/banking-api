defmodule BankingApiWeb.UserController do
  use BankingApiWeb, :controller
  alias BankingApi.Accounts
  # alias BankingApi.Accounts.User

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    json(conn, user_serializer(user))
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        json(conn, user_serializer(user))
      {:error, %Ecto.Changeset{} = changeset} ->
        json(conn, %{error: "Invalid data"})
    end
  end

  defp user_serializer(user) do 
    %{
      id: user.id,
      name: user.name,
      email: user.credential.email
    }
  end
end