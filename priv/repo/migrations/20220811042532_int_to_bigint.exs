defmodule Estore.Repo.Migrations.IntToBigint do
  use Ecto.Migration

  def change do
    alter table("products") do
      remove :sku, :integer, null: false
      add :sku, :bigint, null: false
    end
  end
end
