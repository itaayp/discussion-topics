defmodule Discuss.TopicController do
    @moduledoc """
    This is the Topic Controller and will orchestrate the actions related to the Topic
    """
    use Discuss.Web, :controller
    alias Discuss.Topic
    
    @doc """
    This function displays all the topics records from the database
    """
    def index(conn, _params) do
        topics = Repo.all(Topic)
        render conn, "index.html", topics: topics        
    end

    @doc """
    This function renderizes the New Topic screen.
    The changeset is needed to be passed by parameter when calling the `render` function and it means: "make availble this values, so I can use it on my page"
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
            {:ok, post} -> 
                conn
                |> put_flash(:info, "Topic Created")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} -> 
                render conn, "new.html", changeset: changeset
        end
    end

    @doc """
    This function is responsible to redirects the user to the Edit Topic screen.
    The argument `%{"id" => topic_id}` is the id of the topic selected by the user to edit. This argument is part of the `params` argument
    """
    def edit(conn, %{"id" => topic_id}) do
        topic = Repo.get(Topic, topic_id)
        changeset = Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic     
    end
end