defmodule Discuss.AuthController do
    @moduledoc """
    This is the Auth Controller and will handle the actions related to the Authorize a user to access the application
    """
    use Discuss.Web, :controller
    plug Ueberauth

    def callback(conn, params) do
        IO.puts "++++++"
        IO.inspect(conn.assigns)
        IO.puts "++++++"
        IO.inspect(params)
        IO.puts "++++++"
    end
end