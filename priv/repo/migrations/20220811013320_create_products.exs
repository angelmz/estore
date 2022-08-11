defmodule Estore.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :handle, :string, null: false
      add :title, :string, null: false
      add :sku, :integer, null: false
      add :body, :text, null: false
      add :vendor, :string, null: false
      add :category, :string, null: false
      add :published, :boolean, default: false, null: false
      add :size, :string
      add :color, :string
      add :condition, :string, null: false
      add :inventory_qty, :integer, null: false
      add :price, :integer, null: false
      add :compare_at_price, :integer
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create unique_index(:products, [:user_id])
  end
end
