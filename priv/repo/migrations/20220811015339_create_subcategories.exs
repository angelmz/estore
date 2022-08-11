defmodule Estore.Repo.Migrations.CreateSubcategories do
  use Ecto.Migration

  def change do
    create table(:subcategories) do
      add :title, :string

      timestamps()
    end

    create unique_index(:subcategories, [:title])
  end
end
