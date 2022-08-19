defmodule Estore.Repo.Migrations.DropImagesAndTagsUniqueIndex do
  use Ecto.Migration

  def change do
    drop unique_index(:images, [:user_id, :product_id])
    drop unique_index(:tags, [:user_id, :product_id])
  end
end
