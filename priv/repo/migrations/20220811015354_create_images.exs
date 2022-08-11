defmodule Estore.Repo.Migrations.CreateImages do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :image_src, :string
      add :image_position, :integer
      add :image_alt_text, :string

      timestamps()
    end

    create unique_index(:images, [:image_src])
  end
end
