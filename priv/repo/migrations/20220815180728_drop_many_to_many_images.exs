defmodule Estore.Repo.Migrations.DropManyToManyImages do
  use Ecto.Migration

  def change do
    drop table("product_images")
    drop table("images")
  end
end
