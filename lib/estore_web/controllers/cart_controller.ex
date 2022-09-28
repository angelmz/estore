defmodule EstoreWeb.CartController do
  use EstoreWeb, :controller

  alias Estore.ShoppingCart

  def show(conn, _params) do
    render(conn, "show.html", changeset: ShoppingCart.change_cart(conn.assigns.cart))
  end

  def update(conn, %{"cart" => cart_params}) do
    case ShoppingCart.update_cart(conn.assigns.cart, cart_params) do
      {:ok, cart} ->
        redirect(conn, to: Routes.cart_path(conn, :show))

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "There was an error updating your cart")
        |> redirect(to: Routes.cart_path(conn, :show))
    end
  end

  def fetch_current_cart(conn, _opts) do
    user_id = conn.assigns.current_user.id

    if cart = Estore.ShoppingCart.get_cart_by_user_id(user_id) do
      assign(conn, :cart, cart)
    else
      {:ok, new_cart} = Estore.ShoppingCart.create_cart(user_id)
      assign(conn, :cart, new_cart)
    end
  end
end
