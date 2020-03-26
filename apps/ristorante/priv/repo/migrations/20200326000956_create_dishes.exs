defmodule Ristorante.Repo.Migrations.CreateDishes do
  use Ecto.Migration

  def change do
    create table(:dishes) do
      add :name, :string, null: false
      add :price, :float, null: false
      add :category_id, references(:categories, on_delete: :nothing)

      timestamps()
    end

    create index(:dishes, [:category_id])
  end
end
