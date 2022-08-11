defmodule Estore.Repo.Migrations.CreateProductTags do
  use Ecto.Migration

  def change do
    create table(:product_tags, primary_key: false) do
      add :product_id, references(:products, on_delete: :delete_all)
      add :tag_id, references(:tags, on_delete: :delete_all)
    end

    create index(:product_tags, [:product_id])
    create index(:product_tags, [:tag_id])
    create unique_index(:product_tags, [:product_id, :tag_id])
  end
end
