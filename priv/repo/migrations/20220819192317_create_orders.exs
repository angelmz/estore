defmodule Estore.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :user_id, references(:users, on_delete: :nothing)
      add :total_price, :decimal, null: false

      timestamps()
    end

    create index(:orders, [:user_id])
  end
end
