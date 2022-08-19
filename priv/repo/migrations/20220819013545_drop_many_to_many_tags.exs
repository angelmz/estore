defmodule Estore.Repo.Migrations.DropManyToManyTags do
  use Ecto.Migration

  def change do
    drop table("product_tags")
    drop table("tags")
  end
end
