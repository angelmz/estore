defmodule Estore.Inventory.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :comment, :string
    field :rating, :integer

    belongs_to :product, Estore.Inventory.Product
    belongs_to :user, Estore.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(review, attrs) do
    review
    |> cast(attrs, [:rating, :comment])
    |> validate_required([:rating, :comment])
  end
end
