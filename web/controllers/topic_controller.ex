defmodule Discuss.TopicController do
    @moduledoc """
    This is the Topic Controller and will orchestrate the actions related to the Topic
    """
    use Discuss.Web, :controller
    alias Discuss.Topic
    
    @doc """
    This function renderizes the New Topic screen.
    The changeset is needed to be passed by parameter when calling the `render` function
    """
    def new(conn, _params) do
        changeset = Topic.changeset(%Topic{}, %{})

        render conn, "new.html", changeset: changeset
    end

    @doc """
    This function adds a new row in the `topics` table on the database 
    """
    def create(conn, %{"topic" => topic}) do
        changeset = Topic.changeset(%Topic{}, topic)

        case Repo.insert(changeset) do
            {:ok, post} -> IO.inspect(post)
            {:error, changeset} -> 
                render conn, "new.html", changeset: changeset
        end
    end
end