defmodule BankingApi.Accounts.CurrentUser do
 
  def init(_opts), do: :ok

  def call(conn, _otps) do
    current_user = Guardian.Plug.current_resource(conn)
    Plug.Conn.assign(conn, :current_user, current_user)
  end
end