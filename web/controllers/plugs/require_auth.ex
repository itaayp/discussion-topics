defmodule Discuss.Plugs.RequireAuth do
  @moduledoc """
    This plug is responsible for authorizing the user to access endpoints
  """

  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  @doc """
  mandatory function for module plugs.

  As we do not want to initialize any value, this function will be left blank
  """
  def init(_params) do
  end

  @doc """
  mandatory function for module plugs

  This function gets the `conn` object and checks if there is a value assigned to `user` property. If there is, return the conn, and if there isn't return a message to the user

  `_params` argument is the return value of the `init` function.
  """
  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end
end
