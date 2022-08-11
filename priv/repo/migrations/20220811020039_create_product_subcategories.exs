defmodule Estore.Repo.Migrations.CreateProductSubcategories do
  use Ecto.Migration

  def change do
    create table(:product_subcategories, primary_key: false) do
      add :product_id, references(:products, on_delete: :delete_all)
      add :subcategory_id, references(:subcategories, on_delete: :delete_all)
    end

    create index(:product_subcategories, [:product_id])
    create index(:product_subcategories, [:subcategory_id])
    create unique_index(:product_subcategories, [:product_id, :subcategory_id])
  end
end
