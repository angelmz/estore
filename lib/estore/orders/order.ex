defmodule Estore.Orders.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :total_price, :decimal

    belongs_to :user, Estore.Accounts.User
    has_many :line_items, Estore.Orders.LineItem
    has_many :products, through: [:line_items, :product]

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:total_price])
    |> validate_required([:total_price])
    |> unique_constraint(:user_id)
  end
end
