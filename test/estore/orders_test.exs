defmodule Estore.OrdersTest do
  use Estore.DataCase

  alias Estore.Orders

  describe "orders" do
    alias Estore.Orders.Order
    alias Estore.ShoppingCart

    import Estore.OrdersFixtures

    @invalid_attrs %{total_price: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/2 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id, order.user_id) == order
    end

    # test "complete_order/1 with valid data creates a order" do
    #   cart = shopping_cart_fixture()
    #   # valid_attrs = %ShoppingCart.Cart{total_price: "120.5"}
    #   completed_order = order_fixture()

    #   assert {:ok, %Order{} = order} = Orders.complete_order(cart)
    #   # assert order.total_price == Decimal.new("120.5")
    #   assert order = compå
    # end

    # test "complete_order/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Orders.complete_order(@invalid_attrs)
    # end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{total_price: "456.7"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.total_price == Decimal.new("456.7")
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id, order.user_id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id, order.user_id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end

  describe "order_line_items" do
    alias Estore.Orders.LineItem

    import Estore.OrdersFixtures

    @invalid_attrs %{price: nil, quantity: nil}

    test "list_order_line_items/0 returns all order_line_items" do
      line_item = line_item_fixture()
      assert Orders.list_order_line_items() == [line_item]
    end

    test "get_line_item!/1 returns the line_item with given id" do
      line_item = line_item_fixture()
      assert Orders.get_line_item!(line_item.id) == line_item
    end

    test "create_line_item/1 with valid data creates a line_item" do
      valid_attrs = %{price: "120.5", quantity: 42}

      assert {:ok, %LineItem{} = line_item} = Orders.create_line_item(valid_attrs)
      assert line_item.price == Decimal.new("120.5")
      assert line_item.quantity == 42
    end

    test "create_line_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_line_item(@invalid_attrs)
    end

    test "update_line_item/2 with valid data updates the line_item" do
      line_item = line_item_fixture()
      update_attrs = %{price: "456.7", quantity: 43}

      assert {:ok, %LineItem{} = line_item} = Orders.update_line_item(line_item, update_attrs)
      assert line_item.price == Decimal.new("456.7")
      assert line_item.quantity == 43
    end

    test "update_line_item/2 with invalid data returns error changeset" do
      line_item = line_item_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_line_item(line_item, @invalid_attrs)
      assert line_item == Orders.get_line_item!(line_item.id)
    end

    test "delete_line_item/1 deletes the line_item" do
      line_item = line_item_fixture()
      assert {:ok, %LineItem{}} = Orders.delete_line_item(line_item)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_line_item!(line_item.id) end
    end

    test "change_line_item/1 returns a line_item changeset" do
      line_item = line_item_fixture()
      assert %Ecto.Changeset{} = Orders.change_line_item(line_item)
    end
  end

  describe "orders" do
    alias Estore.Orders.Order

    import Estore.OrdersFixtures

    @invalid_attrs %{total_price: nil, user_id: nil}

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Orders.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Orders.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      valid_attrs = %{total_price: "120.5", user_id: "some user_id"}

      assert {:ok, %Order{} = order} = Orders.create_order(valid_attrs)
      assert order.total_price == Decimal.new("120.5")
      assert order.user_id == "some user_id"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      update_attrs = %{total_price: "456.7", user_id: "some updated user_id"}

      assert {:ok, %Order{} = order} = Orders.update_order(order, update_attrs)
      assert order.total_price == Decimal.new("456.7")
      assert order.user_id == "some updated user_id"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Orders.update_order(order, @invalid_attrs)
      assert order == Orders.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Orders.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Orders.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Orders.change_order(order)
    end
  end
end
