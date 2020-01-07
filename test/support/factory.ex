defmodule BankingApi.Factory do

  # with Ecto
  use ExMachina.Ecto, repo: BankingApi.Repo

  def user_factory do
    %BankingApi.Accounts.User{
      name: Faker.Name.name(),
      credential: build(:credential)
    }
  end

  def credential_factory do
    password = Faker.String.base64()
    %BankingApi.Accounts.Credential{      
      email: Faker.Internet.email(),
      password: password,
      password_hash: password,
    }
  end  

  # def transaction_factory do
  #   %BankingApi.Bank.Transaction{      
  #     user: build(:user),
  #     amount: 10..100 |> Enum.random() |> Money.new()
  #   }
  # end  

  # def balance_factory do
  #   %BankingApi.Bank.Transaction{      
  #     user: build(:user),
  #     amount: 10..100 |> Enum.random() |> Money.new()
  #   }
  # end  
end