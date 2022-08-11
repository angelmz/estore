defmodule Estore.Repo.Migrations.AlterRollToRole do
  use Ecto.Migration

  def change do
    alter table("users") do
      remove :roll
      add :role, :string, null: false
    end
  end
end
