defmodule BankingApi.AccountsTest do
  use BankingApi.DataCase

  alias BankingApi.Accounts.Credential
  alias BankingApi.Accounts.User
  alias BankingApi.Accounts

  import BankingApi.Factory

  @valid_user_attrs %{"name" => Faker.Name.name(), "credential" => %{"email" => Faker.Internet.email(), "password" => Faker.String.base64()}}

  describe "users" do

    test "register_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.register_user(@valid_user_attrs)
      assert user.credential.email == @valid_user_attrs["credential"]["email"]
    end

    test "register_user/1 with used email" do
      assert {:ok, %User{} = user} = Accounts.register_user(@valid_user_attrs)
      assert user.credential.email == @valid_user_attrs["credential"]["email"]
      assert {:error, %Ecto.Changeset{} = changeset} = Accounts.register_user(@valid_user_attrs)      
    end
    
    test "get_user/1 using id" do
      user = insert(:user)
      assert {:ok, %User{} = loaded_user} = Accounts.get_user!(user.id)
      assert loaded_user.id == user.id
    end

    test "get_user/1 using a invalid id" do
      insert(:user)
      assert {:error, _, _} = Accounts.get_user!(500..600 |> Enum.random())      
    end

    test "authenticate_by_email_and_pass/1 using email and passowrd" do
      assert {:ok, %User{} = user} = Accounts.register_user(@valid_user_attrs)
      assert {:ok, %Credential{} = credential} = Accounts.authenticate_by_email_and_pass(@valid_user_attrs["credential"]["email"], @valid_user_attrs["credential"]["password"])
      assert credential.user_id == user.id
    end

    test "authenticate_by_email_and_pass/1 using invalid email and passowrd" do
      assert {:ok, %User{} = user} = Accounts.register_user(@valid_user_attrs)    
      assert {:error, _} = Accounts.authenticate_by_email_and_pass(Faker.Internet.email(), Faker.String.base64())      
    end    
  end
end
