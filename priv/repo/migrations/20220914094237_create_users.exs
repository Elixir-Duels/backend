defmodule Duels.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true, null: false
      add :username, :string
      add :encrypted_password, :string

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
