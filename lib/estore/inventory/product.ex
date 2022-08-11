defmodule Estore.Inventory.Product do
  use Ecto.Schema
  import Ecto.Changeset

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
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:handle, :title, :sku, :body, :vendor, :category, :published, :size, :color, :condition, :inventory_qty, :price, :compare_at_price])
    |> validate_required([:handle, :title, :sku, :body, :vendor, :category, :published, :size, :color, :condition, :inventory_qty, :price, :compare_at_price])
    |> unique_constraint(:user_id)
  end
end
