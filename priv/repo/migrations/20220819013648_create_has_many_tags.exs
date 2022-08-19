defmodule Estore.Repo.Migrations.CreateHasManyTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :title, :string

      add :product_id, references(:products, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:tags, [:product_id])
    create index(:tags, [:user_id])

    create unique_index(:tags, [:user_id, :product_id])
  end
end
