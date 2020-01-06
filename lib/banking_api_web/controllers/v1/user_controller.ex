defmodule BankingApiWeb.V1.UserController do
  use BankingApiWeb, :controller
  alias BankingApi.Accounts
  alias BankingApi.Accounts.User

  # plug :authenticate when action in [:index, :show]

  def index(conn, _params) do
    users = Accounts.list_users()
    json(conn, Enum.map(users, fn user -> Accounts.user_serializer(users) end))
  end

  def show(conn, %{"id" => id}) do
    with {:ok, user } <- id |>  Accounts.get_user!() do
      json(conn, Accounts.user_serializer(user))
    else
      _ -> 
        json(conn, %{error: 'User not found'})
    end
    
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
end