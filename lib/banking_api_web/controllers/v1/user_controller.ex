defmodule BankingApiWeb.V1.UserController do
  use BankingApiWeb, :controller
  alias BankingApi.Accounts
  alias BankingApi.Accounts.User

  # plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    users = Accounts.list_users()
    json(conn, Enum.map(users, fn user -> user_serializer(users) end) )
  end
  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    json(conn, user_serializer(user))
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> json(Accounts.user_serializer(user))
      {:error, %Ecto.Changeset{} = changeset} ->
        json(conn, %{error: "Invalid data"})
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> json(%{error: "You must be logged in to access that page"})
      |> halt()
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