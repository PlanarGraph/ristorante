defmodule Ristorante.Repo.Migrations.AddImagePathToDishes do
  use Ecto.Migration

  def change do
    alter table(:dishes) do
      add :image_path, :string
    end
  end
end
