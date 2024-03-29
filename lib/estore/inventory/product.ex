defmodule Estore.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset
  alias Estore.Inventory.{Subcategory}

  schema "products" do
    field :body, :string
    field :category, :string
    field :color, :string
    field :compare_at_price, :decimal
    field :condition, :string
    field :handle, :string
    field :inventory_qty, :integer
    field :price, :decimal
    field :published, :boolean, default: false
    field :size, :string
    field :sku, :integer
    field :title, :string
    field :vendor, :string

    many_to_many :subcategories, Subcategory, join_through: "product_subcategories", on_replace: :delete

    has_many :tags, Estore.Inventory.Tag
    has_many :reviews, Estore.Inventory.Review
    has_many :images, Estore.Inventory.Image

    belongs_to :user, Estore.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:handle, :title, :sku, :body, :vendor, :category, :published, :size, :color, :condition, :inventory_qty, :price, :compare_at_price])
    |> validate_required([:handle, :title, :sku, :body, :vendor, :category, :published, :condition, :inventory_qty, :price])
    |> unique_constraint(:user_id)
  end
end
