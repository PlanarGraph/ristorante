defmodule Ristorante.Repo.Migrations.AddDescriptionToDish do
  use Ecto.Migration

  def change do
    alter table(:dishes) do
      add :description, :string
    end
  end
end
