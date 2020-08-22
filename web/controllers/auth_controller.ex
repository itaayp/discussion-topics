defmodule Discuss.AuthController do
    @moduledoc """
    This is the Auth Controller and will handle the actions related to the Authorize a user to access the application
    """

    use Discuss.Web, :controller
    plug Ueberauth

    alias Discuss.User

    @doc """
        This function is called when the auth provider calls back our application with the authorized user.
        The goal of the function is to sign in the user to the system
    """
    def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
        user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github"} 
        #TODO: Right now I'm not accepting to login with a different provider from github (`provider: "github"`). I have tried to run the change pasted below, but it didn't work
        # user_params = %{token: auth.credentials.token, email: auth.info.email, provider: auth.provider}
        changeset = User.changeset(%User{}, user_params)

        signin(conn, changeset)
    end

    @doc """
        This function sets the cookie browser `user_id` with the database user_id and redirects him to the index page, but if the sign in failed, the application will just redirect the user
    """
    defp signin(conn, changeset) do
        case insert_or_update_user(changeset) do
            {:ok, user} ->
                conn
                |> put_flash(:info, "Welcome back!")
                |> put_session(:user_id, user.id)
                |> redirect(to: topic_path(conn, :index))            
            {:error, _reason} ->
                conn
                |> put_flash(:error, "Error signin in")
                |> redirect(to: topic_path(conn, :index))
        end
    end

    @doc """
        This is a private function. The goal of the function is to insert the new user on the database, or update their info, if the user already exists on the DB.
    """
    defp insert_or_update_user(changeset) do
        case Repo.get_by(User, email: changeset.changes.email) do
            nil ->
                Repo.insert(changeset)
            user ->
                {:ok, user}
        end
    end
end