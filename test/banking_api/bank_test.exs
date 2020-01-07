defmodule BankingApi.BankTest do
  use BankingApi.DataCase
    
  alias BankingApi.Accounts.User
  alias BankingApi.Accounts
  alias BankingApi.Bank

  @valid_user_1 %{"name" => Faker.Name.name(), "credential" => %{"email" => Faker.Internet.email(), "password" => Faker.String.base64()}}
  @valid_user_2 %{"name" => Faker.Name.name(), "credential" => %{"email" => Faker.Internet.email(), "password" => Faker.String.base64()}}

  describe "user" do
    test "register_user/1 check initial balance" do
      assert {:ok, %User{} = user} = Accounts.register_user(@valid_user_1)
      user = user |> Repo.preload(:balance, force: true)            
      assert user.balance.amount |> Money.equals?(Money.new(100_000))
    end
  end
  
  describe "bank" do
    test "withdraw/2 with valid params" do      
      assert {:ok, %User{} = user} = Accounts.register_user(@valid_user_1)            
      assert {:ok, user, _} = user |> Bank.withdraw(Money.new(30_000))
      user = user |> Repo.preload(:balance, force: true)
      assert user.balance.amount |> Money.equals?(Money.new(70_000))
    end

    test "withdraw/2 with invalid params" do      
      assert {:ok, %User{} = user} = Accounts.register_user(@valid_user_1)            
      assert {:error, "The new balance must be positive", 422} = user |> Bank.withdraw(Money.new(100_00_000))
    end

    test "transfer/3 with valid params" do      
      assert {:ok, %User{} = user_1} = Accounts.register_user(@valid_user_1)      
      assert {:ok, %User{} = user_2} = Accounts.register_user(@valid_user_2)
      assert {:ok, %{from_transaction: from_transaction, to_transaction: to_transaction}} =
      user_1 |> Bank.transfer(user_2, Money.new(100_00))
      user_1 = user_1 |> Repo.preload(:balance, force: true)
      user_2 = user_2 |> Repo.preload(:balance, force: true)
      assert user_1.balance.amount |> Money.equals?(Money.new(90_000))
      assert user_2.balance.amount |> Money.equals?(Money.new(1100_00))
    end

    test "transfer/3 with invalid params" do      
      assert {:ok, %User{} = user_1} = Accounts.register_user(@valid_user_1)      
      assert {:ok, %User{} = user_2} = Accounts.register_user(@valid_user_2)
      assert {:error, :transfer_problems} = user_1 |> Bank.transfer(user_2, Money.new(110_000))      
    end
  end 
end
