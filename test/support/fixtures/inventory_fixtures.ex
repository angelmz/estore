defmodule Estore.InventoryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Estore.Inventory` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        body: "some body",
        category: "some category",
        color: "some color",
        compare_at_price: "120.5",
        condition: "some condition",
        handle: "some handle",
        inventory_qty: 42,
        price: "120.5",
        published: true,
        size: "some size",
        sku: 42,
        title: "some title",
        vendor: "some vendor"
      })
      |> Estore.Inventory.create_product()

    product
  end
end
