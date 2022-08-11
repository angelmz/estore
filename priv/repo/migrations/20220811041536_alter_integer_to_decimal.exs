defmodule Estore.Repo.Migrations.AlterIntegerToDecimal do
  use Ecto.Migration

  def change do
    alter table("products") do
      remove :price, :integer, null: false
      remove :compare_at_price, :integer

      add :price, :decimal, null: false
      add :compare_at_price, :decimal
    end
  end
end
