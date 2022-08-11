defmodule Estore.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def change do
    create table(:reviews) do
      add :rating, :integer, null: false
      add :comment, :string, null: false
      add :product_id, references(:products, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:reviews, [:product_id])
    create index(:reviews, [:user_id])

    create unique_index(:reviews, [:user_id, :product_id],
    name: :index_reviews_on_user_product)
  end
end
