defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    # Create a table called "topics" and a column of strings called "title"
    create table (:topics) do
        add :title, :string
    end
  end
end
