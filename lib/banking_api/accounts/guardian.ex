defmodule BankingApi.Accounts.Guardian do
  use Guardian, otp_app: :banking_api

  alias BankingApi.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_credential!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end