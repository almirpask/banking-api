defmodule BankingApiWeb.V1.SessionController do
  use BankingApiWeb, :controller

  alias BankingApi.{Accounts, Accounts.User, Accounts.Guardian}

  def create(conn, %{"user" => user}) do    
    case BankingApi.Accounts.authenticate_by_email_and_pass(user["email"], user["password"]) do
      {:ok, user} ->
        {:ok, jwt, _claims}  =  Guardian.encode_and_sign(user)           
        conn
        |> json(%{token: jwt})        
      {:error, _reason} ->
        conn
        |> json(%{error: "Invalid email/password combination"})        
        
    end
  end
end