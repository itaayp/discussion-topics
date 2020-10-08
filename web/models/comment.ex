defmodule Discuss.Comment do
@moduledoc """
  Comment's Model
"""

  use Discuss.Web, :model

  @derive {Poison.Encoder, only: [:content, :user]}

  schema "comments" do
    field :content, :string
    belongs_to :user, Discuss.User
    belongs_to :topic, Discuss.Topic

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:content])
    |> validate_required([:content])
  end
end
