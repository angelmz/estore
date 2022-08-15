defmodule Estore.Repo.Migrations.CreateOneToManyImages do
  use Ecto.Migration

  defmodule Estore.Repo.Migrations.CreateReviews do
    use Ecto.Migration

    def change do
      create table(:images) do
        add :image_src, :string
        add :image_position, :integer
        add :image_alt_text, :string
        add :product_id, references(:products, on_delete: :nothing)
        add :user_id, references(:users, on_delete: :delete_all), null: false

        timestamps()
      end

      create index(:images, [:product_id])
      create index(:images, [:user_id])

      create unique_index(:images, [:user_id, :product_id])
    end
  end

end
