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
    scope "/v1", V1, as: :v1 do
      post "/signin", SessionController, :create
      post "/signup", UserController, :create
    end 
  end
  scope "/api", BankingApiWeb do
    pipe_through [:api, :auth, :ensure_auth]
    resources "/users", UserController, only: [:show, :index]    
    resources "/users", UserController, only: [:show, :index]    
  end
end
