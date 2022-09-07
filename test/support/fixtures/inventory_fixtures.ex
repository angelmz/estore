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
        sku: 123456789123,
        title: "some title",
        vendor: "some vendor",
        user_id: 1
      })
      |> Estore.Inventory.create_product()

    product
  end

  @doc """
  Generate a unique subcategory title.
  """
  def unique_subcategory_title, do: "some title#{System.unique_integer([:positive])}"

  @doc """
  Generate a subcategory.
  """
  def subcategory_fixture(attrs \\ %{}) do
    {:ok, subcategory} =
      attrs
      |> Enum.into(%{
        title: unique_subcategory_title()
      })
      |> Estore.Inventory.create_subcategory()

    subcategory
  end

  @doc """
  Generate a unique tag title.
  """
  def unique_tag_title, do: "some title#{System.unique_integer([:positive])}"

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        title: unique_tag_title()
      })
      |> Estore.Inventory.create_tag()

    tag
  end

  @doc """
  Generate a unique image image_src.
  """
  def unique_image_image_src, do: "some image_src#{System.unique_integer([:positive])}"

  @doc """
  Generate a image.
  """
  def image_fixture(attrs \\ %{}) do
    {:ok, image} =
      attrs
      |> Enum.into(%{
        image_alt_text: "some image_alt_text",
        image_position: 42,
        image_src: unique_image_image_src()
      })
      |> Estore.Inventory.create_image()

    image
  end

  @doc """
  Generate a review.
  """
  def review_fixture(attrs \\ %{}) do
    {:ok, review} =
      attrs
      |> Enum.into(%{
        comment: "some comment",
        rating: 42,
        product_id: 1,
        user_id: 1,
      })
      |> Estore.Inventory.create_review()

    review
  end
end
