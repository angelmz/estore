defmodule EstoreWeb.ProductControllerTest do
  use EstoreWeb.ConnCase

  import Estore.InventoryFixtures

  @create_attrs %{body: "some body", category: "some category", color: "some color", compare_at_price: "120.5", condition: "some condition", handle: "some handle", inventory_qty: 42, price: "120.5", published: true, size: "some size", sku: 42, title: "some title", vendor: "some vendor"}
  @update_attrs %{body: "some updated body", category: "some updated category", color: "some updated color", compare_at_price: "456.7", condition: "some updated condition", handle: "some updated handle", inventory_qty: 43, price: "456.7", published: false, size: "some updated size", sku: 43, title: "some updated title", vendor: "some updated vendor"}
  @invalid_attrs %{body: nil, category: nil, color: nil, compare_at_price: nil, condition: nil, handle: nil, inventory_qty: nil, price: nil, published: nil, size: nil, sku: nil, title: nil, vendor: nil}

  describe "index" do
    test "lists all products", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Products"
    end
  end

  describe "new product" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.product_path(conn, :new))
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "create product" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.product_path(conn, :show, id)

      conn = get(conn, Routes.product_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Product"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.product_path(conn, :create), product: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Product"
    end
  end

  describe "edit product" do
    setup [:create_product]

    test "renders form for editing chosen product", %{conn: conn, product: product} do
      conn = get(conn, Routes.product_path(conn, :edit, product))
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "update product" do
    setup [:create_product]

    test "redirects when data is valid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @update_attrs)
      assert redirected_to(conn) == Routes.product_path(conn, :show, product)

      conn = get(conn, Routes.product_path(conn, :show, product))
      assert html_response(conn, 200) =~ "some updated body"
    end

    test "renders errors when data is invalid", %{conn: conn, product: product} do
      conn = put(conn, Routes.product_path(conn, :update, product), product: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Product"
    end
  end

  describe "delete product" do
    setup [:create_product]

    test "deletes chosen product", %{conn: conn, product: product} do
      conn = delete(conn, Routes.product_path(conn, :delete, product))
      assert redirected_to(conn) == Routes.product_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.product_path(conn, :show, product))
      end
    end
  end

  defp create_product(_) do
    product = product_fixture()
    %{product: product}
  end
end
