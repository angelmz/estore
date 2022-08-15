defmodule Estore.Inventory.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :image_alt_text, :string
    field :image_position, :integer
    field :image_src, :string

    belongs_to :product, Estore.Inventory.Product
    belongs_to :user, Estore.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:image_src, :image_position, :image_alt_text])
    |> validate_required([:image_src, :image_position, :image_alt_text])
    |> unique_constraint(:image_src)
  end
end
