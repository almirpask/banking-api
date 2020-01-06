defmodule BankingApi.Bank do
  @moduledoc """
  The Bank context.
  """

  import Ecto.Query, warn: false

  alias BankingApi.Repo
  alias BankingApi.Accounts.User
  alias BankingApi.Bank.{Balance, Transaction}
  @initial_deposit_value Money.new(100_000)

  @doc """
  Returns the list of balances.

  ## Examples

      iex> list_balances()
      [%Balance{}, ...]

  """
  def list_balances do
    Repo.all(Balance)
  end

  @doc """
  Gets a single balance.

  Raises `Ecto.NoResultsError` if the Balance does not exist.

  ## Examples

      iex> get_balance!(123)
      %Balance{}

      iex> get_balance!(456)
      ** (Ecto.NoResultsError)

  """
  def get_balance!(id), do: Repo.get_by(Balance, user_id: id)

  @doc """
  Creates a balance.

  ## Examples

      iex> create_balance_and_first_deposit(%{field: value})
      {:ok, %Balance{}}

      iex> create_balance_and_first_deposit(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_balance_and_first_deposit(user \\ %{}) do    
    with %Balance{}
      |> Balance.changeset(%{user_id: user.id, amount: Money.new(0)})
      |> Repo.insert() do 
      deposit(user, @initial_deposit_value)
    end
  end

  @doc """
  Updates a balance.

  ## Examples

      iex> update_balance(balance, %{field: new_value})
      {:ok, %Balance{}}

      iex> update_balance(balance, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  defp check_positive(%Balance{} = balance, amount) do
    balance.amount
    |> Money.add(amount)
    |> Money.positive?()
  end

  defp update_balance(%Balance{} = balance, amount) do
    if check_positive(balance, amount) do
      new_amount = balance.amount |> Money.add(amount)
      balance
      |> Balance.changeset(%{amount: new_amount})
      |> Repo.update()
    else
      {:error, "The new balance must be positive", 422}
    end
  end

  @doc """
  Deletes a Balance.

  ## Examples

      iex> delete_balance(balance)
      {:ok, %Balance{}}

      iex> delete_balance(balance)
      {:error, %Ecto.Changeset{}}

  """
  def delete_balance(%Balance{} = balance) do
    Repo.delete(balance)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking balance changes.

  ## Examples

      iex> change_balance(balance)
      %Ecto.Changeset{source: %Balance{}}

  """
  def change_balance(%Balance{} = balance) do
    Balance.changeset(balance, %{})
  end

  alias BankingApi.Bank.Transaction

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction)
  end

  def transfer(%User{id: from_user}, %User{id: to_user}, %Money{} = amount) do
    from_user_amount = 
      amount
      |> Money.abs()
      |> Money.neg()
    from_user_amount = 
      amount
      |> Money.abs()
    Repo.transaction(fn ->    
      with {:ok, from_transaction} <- create_transaction(%{user_id: from_user, amount: from_user_amount}),
          {:ok, to_transaction} <- create_transaction(%{user_id: to_user, amount: from_user_amount}),
          %Balance{} = from_balance <- from_user |> get_balance!(),
          %Balance{} = to_balance <- to_user |> get_balance!(),
          {:ok, _} <- from_balance |> update_balance(from_transaction.amount),
          {:ok, _} <- to_balance |> update_balance(to_transaction.amount) do
        %{
          from_transaction: %{
            transaction_id: from_transaction.id,
            user_id: from_user,
            amount: from_transaction.amount,
            date: from_transaction.inserted_at
          },
          to_transaction: %{
            transaction_id: to_transaction.id,
            user_id: to_user,
            amount: to_transaction.amount,
            date: to_transaction.inserted_at
          }
        }
      else
        _ -> Repo.rollback(:transfer_problems)
      end
    end)
  end

  def transfer(_, _, _), do: {:error, "Invalid accounts"}
  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{source: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction) do
    Transaction.changeset(transaction, %{})
  end
  
  @doc """
    make a deposit to a specific account
  ## Examples
      iex> account |> deposit(Money.new(1000))
      {:ok, %Account{}, %Transaction{}}
  """
  def deposit(%User{id: user_id} = user, %Money{} = amount) do    
    with {:ok, transaction } <- create_transaction(%{user_id: user_id, amount: amount}),
      %Balance{} = balance <- user_id |> get_balance!(),
      {:ok, _} = balance |> update_balance(transaction.amount)
      do
        user = user
          |> Repo.preload(:balance)
          |> Repo.preload(:credential)
        {:ok, user, transaction}
    end
  end

  def withdraw(%User{id: user_id} = user, %Money{} = amount) do
    new_amount = amount |> Money.abs() |> Money.neg()
    with {:ok, transaction} <- create_transaction(%{user_id: user_id, amount: new_amount}),
        %Balance{} = balance <- get_balance!(user_id),
        {:ok, _} <- balance |> update_balance(new_amount) do
        Task.async(fn -> BankingApi.Mailer.withdraw(user, transaction) end)
        {:ok, user, transaction}
    end
  end
end
