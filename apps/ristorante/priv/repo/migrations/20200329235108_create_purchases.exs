defmodule Ristorante.Repo.Migrations.CreatePurchases do
  use Ecto.Migration

  def change do
    create table(:purchases) do
      add :items, :map
      add :total, :float
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:purchases, [:user_id])
  end
end
