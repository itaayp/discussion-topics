defmodule Discuss.TopicController do
    @moduledoc """
    This is the Topic Controller and will handle the actions related to the Topic
    """
    use Discuss.Web, :controller

    alias Discuss.Topic

    plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
    plug :check_topic_owner when action in [:update, :edit, :delete]

    @doc """
    This function displays all the topics records from the database
    """
    def index(conn, _params) do
        topics = Repo.all(Topic)
        render conn, "index.html", topics: topics
    end

    @doc """
      This function shows the details of an especific topic
    """
    def show(conn, %{"id" => topic_id}) do
      topic = Repo.get!(Topic, topic_id)
      render conn, "show.html", topic: topic
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
        changeset = conn.assigns.user
          |> build_assoc(:topics)
          |> Topic.changeset(topic)

        case Repo.insert(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic Created")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "new.html", changeset: changeset
        end
    end

    @doc """
    This function is responsible to redirect the user to the Edit Topic screen.
    The argument `%{"id" => topic_id}` is the id of the topic selected by the user to edit. This argument is part of the `params` argument
    """
    def edit(conn, %{"id" => topic_id}) do
        topic = Repo.get(Topic, topic_id)
        changeset = Topic.changeset(topic)

        render conn, "edit.html", changeset: changeset, topic: topic
    end

    @doc """
        This function updates the value on the database of a topic already created
    """
    def update(conn, %{"id" => topic_id, "topic" => topic}) do
        old_topic = Repo.get(Topic, topic_id)
        changeset = Topic.changeset(old_topic, topic)

        case Repo.update(changeset) do
            {:ok, _topic} ->
                conn
                |> put_flash(:info, "Topic Updated")
                |> redirect(to: topic_path(conn, :index))
            {:error, changeset} ->
                render conn, "edit.html", changeset: changeset, topic: old_topic
        end
    end

    @doc """
        This function deletes a topic from the database
    """
    def delete(conn, %{"id" => topic_id}) do
        Repo.get!(Topic, topic_id) |> Repo.delete!

        conn
        |> put_flash(:info, "Topic Deleted")
        |> redirect(to: topic_path(conn, :index))
    end

    @doc """
    This plug checks if the user is the owner of the topic that he/she is trying to access
    """
    def check_topic_owner(conn, _params) do
      %{params: %{"id" => topic_id}} = conn

      if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
        conn
      else
        conn
        |> put_flash(:error, "You can not edit this topic")
        |> redirect(to: topic_path(conn, :index))
        |> halt()
      end
    end
end
