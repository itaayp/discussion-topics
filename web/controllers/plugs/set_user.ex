defmodule Discuss.Plugs.SetUser do
@moduledoc """
SetUser plug.
"""
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User

  @doc """
  mandatory function for module plugs.

  As we do not want to initialize any value, this function will be left blank
  """
  def init(_params) do
  end

  @doc """
  mandatory function for module plugs

  This function gets the `conn` object, see if there is a `user_id`. And if there is, it will find the user in the database and assign it to the `conn`

  `_params` argument is the return value of the `init` function.
  """
  def call(conn, _params) do
    user_id = get_session(conn, :user_id)

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end
end
