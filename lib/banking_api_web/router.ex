defmodule BankingApiWeb.Router do
  use BankingApiWeb, :router

  pipeline :auth do
    plug BankingApi.Accounts.Pipeline
  end
    
  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end
  
  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BankingApiWeb do
    pipe_through [:api, :auth]    
    resources "/sessions", SessionController, only: [:create]
  end
  scope "/api", BankingApiWeb do
    pipe_through [:api, :auth, :ensure_auth]
    resources "/users", UserController, only: [:create, :show, :index]    
  end
end
