defmodule Estore.Repo.Migrations.CreateProductImages do
  use Ecto.Migration

  def change do
    create table(:product_images, primary_key: false) do
      add :product_id, references(:products, on_delete: :delete_all)
      add :image_id, references(:images, on_delete: :delete_all)
    end

    create index(:product_images, [:product_id])
    create index(:product_images, [:image_id])
    create unique_index(:product_images, [:product_id, :image_id])
  end
end
