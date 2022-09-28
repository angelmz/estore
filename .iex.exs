import ExUnit.Assertions
import IEx.Helpers

alias Estore.Inventory
alias Estore.Inventory.{Product, Image, Subcategory, Tag, Review}
alias Estore.Accounts
alias Estore.Accounts.User
alias Estore.ShoppingCart
# alias Estore.ShoppingCart.{Cart, CartItem}
alias Estore.Orders
# alias Estore.Orders.{Order, LineItem}
alias Estore.Repo

import_if_available Ecto.Query

import_if_available Ecto.Changeset

defmodule H do

  # def update(schema, changes) do
  #   schema
  #   |> Ecto.Changeset.change(changes)
  #   |> Repo.update
  # end

  def start do
    Accounts.create_role(%{title: "seller"})
    Accounts.create_role(%{title: "customer"})

    seth = %{
      full_name: "Seth Horsley",
      email: "seller@seller.com",
      role_id: 1,
      password: "Hello world1!",
      hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
    }

    mens_jacket = %{
      "handle" => "mens-fall-jacket",
      "title" => "Men's Fall Jacket",
      "sku" => "100000000000",
      "body" => "Men's Fall Fashion Jacket",
      "vendor" => "stylegucci",
      "category" => "apperal",
      "published" => "true",
      "size" => "small",
      "color" => "red",
      "condition" => "new",
      "inventory_qty" => "5",
      "price" => "19.99",
      "compare_at_price" => "39.99",
      "subcategory_ids" => "1",
      "tags" => [
        %{
          "title" => "fall",

        },
        %{
          "title" => "gucci",
        },
      ],
      "images" => [
        %{
          "image_src" => "https://burst.shopifycdn.com/photos/mens-fall-fashion-jacket.jpg?width=925&exif=1&iptc=1/1",
          "image_position" => "1",
          "image_alt_text" => "Mens Fall Fashion Jacket",
        },
        %{
          "image_src" => "https://facebook.com",
          "image_position" => "2",
          "image_alt_text" => "The Jacket",
        }
      ],
    }

    danica = %{
      full_name: "Danica Sebastion",
      email: "danica@user.com",
      role_id: 2,
      password: "Hello world1!",
      hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
    }

    Inventory.create_subcategory(%{title: "Men's Clothing"})

    {:ok, seller} = Accounts.register_user(seth)
    {:ok, customer1} = Accounts.register_user(danica)

    {:ok, product} = Inventory.create_product(seller, mens_jacket)
    {:ok, cart} = ShoppingCart.create_cart(customer1)
    ShoppingCart.add_item_to_cart(cart, product)
    cart = ShoppingCart.get_cart_by_user_id(2)
    {:ok, order} = Orders.complete_order(cart)
  end

  def update do
    mens_jacket = %{
      "product" => %{
        "handle" => "mens-fall-jacket",
        "title" => "Men's Fall Jacket",
        "sku" => "100000000000",
        "body" => "Men's Fall Fashion Jacket",
        "vendor" => "stylegucci",
        "category" => "apperal",
        "published" => "true",
        "size" => "small",
        "color" => "red",
        "condition" => "new",
        "inventory_qty" => "5",
        "price" => "19.99",
        "compare_at_price" => "39.99",
        "subcategory_ids" => "1",
      },
      "tags" => [
        %{
          "title" => "fall",

        },
        %{
          "title" => "gucci",
        },
      ],
      "images" => [
        %{
          "image_src" => "https://burst.shopifycdn.com/photos/mens-fall-fashion-jacket.jpg?width=925&exif=1&iptc=1/1",
          "image_position" => "1",
          "image_alt_text" => "Mens Fall Fashion Jacket",
        },
        %{
          "image_src" => "https://facebook.com",
          "image_position" => "2",
          "image_alt_text" => "The Jacket",
        }
      ],
    }
    # mens_jacket = %{
    #   handle: "mens-fall-jacket",
    #   title: "Men's Fall Jacket",
    #   sku: 100000000000,
    #   body: "Men's Fall Fashion Jacket ",
    #   vendor: "stylegucci",
    #   category: "apperal",
    #   published: true,
    #   size: "small",
    #   color: "red",
    #   condition: "new",
    #   inventory_qty: 5,
    #   price: Decimal.new("19.99"),
    #   compare_at_price: Decimal.new("39.99"),
    #   subcategory_ids: [1],
    #   tags: [
    #     %{
    #       title: "fall",

    #     },
    #     %{
    #       title: "gucci",
    #     },
    #   ],
    #   images: [
    #     %{
    #       image_src: "https://burst.shopifycdn.com/photos/mens-fall-fashion-jacket.jpg?width=925&exif=1&iptc=1/1",
    #       image_position: 1,
    #       image_alt_text: "Mens Fall Fashion Jacket",
    #     },
    #     %{
    #       image_src: "https://facebook.com",
    #       image_position: 2,
    #       image_alt_text: "The Jacket",
    #     }
    #   ],
    # }

    ######### Acceptance test #########
    seller = Accounts.get_user_by_email("seller@seller.com")
    {:ok, product} = Inventory.create_product(seller, mens_jacket)
    customer1 = Accounts.get_user_by_email("danica@user.com")
    {:ok, cart} = ShoppingCart.create_cart(customer1)
    ShoppingCart.add_item_to_cart(cart, product)
    cart = ShoppingCart.get_cart_by_user_id(2)
    {:ok, order} = Orders.complete_order(cart)
    ######### Acceptance test #########
  end
end
