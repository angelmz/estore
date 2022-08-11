defmodule Estore.InventoryTest do
  use Estore.DataCase

  alias Estore.Inventory

  describe "products" do
    alias Estore.Inventory.Product

    import Estore.InventoryFixtures

    @invalid_attrs %{body: nil, category: nil, color: nil, compare_at_price: nil, condition: nil, handle: nil, inventory_qty: nil, price: nil, published: nil, size: nil, sku: nil, title: nil, vendor: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Inventory.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Inventory.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{body: "some body", category: "some category", color: "some color", compare_at_price: "120.5", condition: "some condition", handle: "some handle", inventory_qty: 42, price: "120.5", published: true, size: "some size", sku: 42, title: "some title", vendor: "some vendor"}

      assert {:ok, %Product{} = product} = Inventory.create_product(valid_attrs)
      assert product.body == "some body"
      assert product.category == "some category"
      assert product.color == "some color"
      assert product.compare_at_price == Decimal.new("120.5")
      assert product.condition == "some condition"
      assert product.handle == "some handle"
      assert product.inventory_qty == 42
      assert product.price == Decimal.new("120.5")
      assert product.published == true
      assert product.size == "some size"
      assert product.sku == 42
      assert product.title == "some title"
      assert product.vendor == "some vendor"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{body: "some updated body", category: "some updated category", color: "some updated color", compare_at_price: "456.7", condition: "some updated condition", handle: "some updated handle", inventory_qty: 43, price: "456.7", published: false, size: "some updated size", sku: 43, title: "some updated title", vendor: "some updated vendor"}

      assert {:ok, %Product{} = product} = Inventory.update_product(product, update_attrs)
      assert product.body == "some updated body"
      assert product.category == "some updated category"
      assert product.color == "some updated color"
      assert product.compare_at_price == Decimal.new("456.7")
      assert product.condition == "some updated condition"
      assert product.handle == "some updated handle"
      assert product.inventory_qty == 43
      assert product.price == Decimal.new("456.7")
      assert product.published == false
      assert product.size == "some updated size"
      assert product.sku == 43
      assert product.title == "some updated title"
      assert product.vendor == "some updated vendor"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_product(product, @invalid_attrs)
      assert product == Inventory.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Inventory.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Inventory.change_product(product)
    end
  end
end
