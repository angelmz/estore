defmodule Estore.ShoppingCart do
  @moduledoc """
  The ShoppingCart context.
  """

  import Ecto.Query, warn: false
  alias Estore.Repo

  alias Estore.ShoppingCart.{Cart, CartItem}
  alias Estore.Inventory
  alias Estore.Accounts



  @doc """
  Returns the list of carts.

  ## Examples

      iex> list_carts()
      [%Cart{}, ...]

  """
  def list_carts do
    Repo.all(Cart)
  end

  @doc """
  Gets a single cart.

  Raises `Ecto.NoResultsError` if the Cart does not exist.

  ## Examples

      iex> get_cart!(123)
      %Cart{}

      iex> get_cart!(456)
      ** (Ecto.NoResultsError)

  """
  # def get_cart!(id), do: Repo.get!(Cart, id)

  def get_cart_by_user_id(user_id) do
    Repo.one(
      from(c in Cart,
        where: c.user_id == ^user_id,
        left_join: i in assoc(c, :items),
        left_join: p in assoc(i, :product),
        order_by: [asc: i.inserted_at],
        preload: [items: {i, product: p}]
      )
    )
  end

  @doc """
  Creates a cart.

  ## Examples

      iex> create_cart(%{field: value})
      {:ok, %Cart{}}

      iex> create_cart(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # attrs = {"user_id" => "1"}

  # The Following functions have been tested and work
  # current_user = Estore.Accounts.get_user!(5)
  # cart = Estore.ShoppingCart.create_cart(current_user)
  # product1 = Estore.Inventory.get_product!("1")
  # product2 = Estore.Inventory.get_product!("2")
  # cart1 = Estore.ShoppingCart.get_cart(1)
  # Estore.ShoppingCart.add_item_to_cart(cart, product1)
  # Estore.ShoppingCart.add_item_to_cart(cart, product2)
  # ShoppingCart.total_cart_price(cart)



  # Tip: When structs are in parameters instead of attrs, it means use their get function.
  # def add_item_to_cart(%Cart{} = cart, %Inventory.Product{} = product) do


  def create_cart(%Accounts.User{} = user) do
    %Cart{}
    |> Cart.changeset(%{})
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
    |> case do
      {:ok, cart} -> {:ok, reload_cart(cart)}
      {:error, changeset} -> {:error, changeset}
    end
  end

  defp reload_cart(%Cart{} = cart), do: get_cart_by_user_id(cart.user_id)

  def add_item_to_cart(%Cart{} = cart, %Inventory.Product{} = product) do
    %CartItem{quantity: 1, price_when_carted: product.price}
    |> CartItem.changeset(%{})
    |> Ecto.Changeset.put_assoc(:cart, cart)
    |> Ecto.Changeset.put_assoc(:product, product)
    |> Repo.insert(
      on_conflict: [inc: [quantity: 1]],
      conflict_target: [:cart_id, :product_id]
    )
  end

  def remove_item_from_cart(%Cart{} = cart, product_id) do
    {1, _} =
      Repo.delete_all(
        from(i in CartItem,
          where: i.cart_id == ^cart.id,
          where: i.product_id == ^product_id
        )
      )

    {:ok, reload_cart(cart)}
  end

  def total_item_price(%CartItem{} = item) do
    Decimal.mult(item.product.price, item.quantity)
  end

  def total_cart_price(%Cart{} = cart) do
    Enum.reduce(cart.items, 0, fn item, acc ->
      item
      |> total_item_price()
      |> Decimal.add(acc)
    end)
  end

  def update_cart(%Cart{} = cart, attrs) do
    changeset =
      cart
      |> Cart.changeset(attrs)
      |> Ecto.Changeset.cast_assoc(:items, with: &CartItem.changeset/2)

    Ecto.Multi.new()
    |> Ecto.Multi.update(:cart, changeset)
    |> Ecto.Multi.delete_all(:discarded_items, fn %{cart: cart} ->
      from(i in CartItem, where: i.cart_id == ^cart.id and i.quantity == 0)
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{cart: cart}} -> {:ok, cart}
      {:error, :cart, changeset, _changes_so_far} -> {:error, changeset}
    end
  end

  def prune_cart_items(%Cart{} = cart) do
    {_, _} = Repo.delete_all(from(i in CartItem, where: i.cart_id == ^cart.id))
    {:ok, reload_cart(cart)}
  end

  @doc """
  Deletes a cart.

  ## Examples

      iex> delete_cart(cart)
      {:ok, %Cart{}}

      iex> delete_cart(cart)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cart(%Cart{} = cart) do
    Repo.delete(cart)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cart changes.

  ## Examples

      iex> change_cart(cart)
      %Ecto.Changeset{data: %Cart{}}

  """
  def change_cart(%Cart{} = cart, attrs \\ %{}) do
    Cart.changeset(cart, attrs)
  end

  @doc """
  Returns the list of cart_items.

  ## Examples

      iex> list_cart_items()
      [%CartItem{}, ...]

  """
  def list_cart_items do
    Repo.all(CartItem)
  end

  @doc """
  Gets a single cart_item.

  Raises `Ecto.NoResultsError` if the Cart item does not exist.

  ## Examples

      iex> get_cart_item!(123)
      %CartItem{}

      iex> get_cart_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_cart_item!(id), do: Repo.get!(CartItem, id)

  @doc """
  Creates a cart_item.

  ## Examples

      iex> create_cart_item(%{field: value})
      {:ok, %CartItem{}}

      iex> create_cart_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_cart_item(attrs \\ %{}) do
    %CartItem{}
    |> CartItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a cart_item.

  ## Examples

      iex> update_cart_item(cart_item, %{field: new_value})
      {:ok, %CartItem{}}

      iex> update_cart_item(cart_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_cart_item(%CartItem{} = cart_item, attrs) do
    cart_item
    |> CartItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a cart_item.

  ## Examples

      iex> delete_cart_item(cart_item)
      {:ok, %CartItem{}}

      iex> delete_cart_item(cart_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_cart_item(%CartItem{} = cart_item) do
    Repo.delete(cart_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking cart_item changes.

  ## Examples

      iex> change_cart_item(cart_item)
      %Ecto.Changeset{data: %CartItem{}}

  """
  def change_cart_item(%CartItem{} = cart_item, attrs \\ %{}) do
    CartItem.changeset(cart_item, attrs)
  end
end
