defmodule Discuss.User do
@moduledoc """
    This is the User's Model and is responsible to integrate all the user's data with the database
"""
    use Discuss.Web, :model

    @derive {Poison.Encoder, only: [:email]}

    @doc """
        This is the mapping function that match the database columns with Elixir's code
    """
    schema "users" do
        field :email, :string
        field :provider, :string
        field :token, :string
        has_many :topics, Discuss.Topic
        has_many :comments, Discuss.Comment

        timestamps()
    end

    @doc """
        This function casts the information from the database to a Elixir format and validates the information.
        The params of the function is a `struct` wich will be used to identify the table on the database, and a `params`. If the `params` is `nil`, the default value is `%{}`
    """
    # params \\ %{} defines a default value for params
    def changeset(struct, params \\ %{}) do
        struct
        |> cast(params, [:email, :provider, :token])
        |> validate_required([:email, :provider, :token]) #this function says that the values of `[:email, :provider, :token]` are required
    end

end
