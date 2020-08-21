defmodule Discuss.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table (:users) do
        add :email, :string
        add :provider, :string
        add :token, :string

        # this function creates the `inserted_at` and `updated_at` dates columns
        timestamps()
    end
  end
end
