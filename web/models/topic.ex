defmodule Discuss.Topic do
@moduledoc """
This is the Topic's Model from MVC.
This module is responsible to handle the data
"""
    use Discuss.Web, :model

    @doc """
    This is the creation of a table `topics` with a column called `title` on the database
    """
    schema "topics" do
        field :title, :string
    end

    @doc """
    This function cast a information from the database to a Elixir format and validates the information
    The params of the function is a `struct` wich will be used to identify the table on the database, and a `params`, that if the `params` is `nil` or it's not passed, the default value is `%{}`
    """
    # params \\ %{} defines a default value for params
    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:title])
        |> validate_required([:title])
    end
end