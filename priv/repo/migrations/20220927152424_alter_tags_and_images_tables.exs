defmodule Estore.Repo.Migrations.AlterTagsAndImagesTables do
  use Ecto.Migration

  def change do
    alter table("tags") do
      remove :product_id, references(:products, on_delete: :delete_all), null: false
      remove :user_id, references(:users, on_delete: :delete_all), null: false

      add :product_id, references(:products, on_delete: :delete_all)
      add :user_id, references(:users, on_delete: :delete_all)
    end

    alter table("images") do
      remove :user_id, references(:users, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
