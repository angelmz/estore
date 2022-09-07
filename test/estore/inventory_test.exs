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

  describe "subcategories" do
    alias Estore.Inventory.Subcategory

    import Estore.InventoryFixtures

    @invalid_attrs %{title: nil}

    test "list_subcategories/0 returns all subcategories" do
      subcategory = subcategory_fixture()
      assert Inventory.list_subcategories() == [subcategory]
    end

    test "get_subcategory!/1 returns the subcategory with given id" do
      subcategory = subcategory_fixture()
      assert Inventory.get_subcategory!(subcategory.id) == subcategory
    end

    test "create_subcategory/1 with valid data creates a subcategory" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Subcategory{} = subcategory} = Inventory.create_subcategory(valid_attrs)
      assert subcategory.title == "some title"
    end

    test "create_subcategory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_subcategory(@invalid_attrs)
    end

    test "update_subcategory/2 with valid data updates the subcategory" do
      subcategory = subcategory_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Subcategory{} = subcategory} = Inventory.update_subcategory(subcategory, update_attrs)
      assert subcategory.title == "some updated title"
    end

    test "update_subcategory/2 with invalid data returns error changeset" do
      subcategory = subcategory_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_subcategory(subcategory, @invalid_attrs)
      assert subcategory == Inventory.get_subcategory!(subcategory.id)
    end

    test "delete_subcategory/1 deletes the subcategory" do
      subcategory = subcategory_fixture()
      assert {:ok, %Subcategory{}} = Inventory.delete_subcategory(subcategory)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_subcategory!(subcategory.id) end
    end

    test "change_subcategory/1 returns a subcategory changeset" do
      subcategory = subcategory_fixture()
      assert %Ecto.Changeset{} = Inventory.change_subcategory(subcategory)
    end
  end

  describe "tags" do
    alias Estore.Inventory.Tag

    import Estore.InventoryFixtures

    @invalid_attrs %{title: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Inventory.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Inventory.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Tag{} = tag} = Inventory.create_tag(valid_attrs)
      assert tag.title == "some title"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Tag{} = tag} = Inventory.update_tag(tag, update_attrs)
      assert tag.title == "some updated title"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_tag(tag, @invalid_attrs)
      assert tag == Inventory.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Inventory.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Inventory.change_tag(tag)
    end
  end

  describe "images" do
    alias Estore.Inventory.Image

    import Estore.InventoryFixtures

    @invalid_attrs %{image_alt_text: nil, image_position: nil, image_src: nil}

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Inventory.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Inventory.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      valid_attrs = %{image_alt_text: "some image_alt_text", image_position: 42, image_src: "some image_src"}

      assert {:ok, %Image{} = image} = Inventory.create_image(valid_attrs)
      assert image.image_alt_text == "some image_alt_text"
      assert image.image_position == 42
      assert image.image_src == "some image_src"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      update_attrs = %{image_alt_text: "some updated image_alt_text", image_position: 43, image_src: "some updated image_src"}

      assert {:ok, %Image{} = image} = Inventory.update_image(image, update_attrs)
      assert image.image_alt_text == "some updated image_alt_text"
      assert image.image_position == 43
      assert image.image_src == "some updated image_src"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_image(image, @invalid_attrs)
      assert image == Inventory.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Inventory.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Inventory.change_image(image)
    end
  end

  describe "reviews" do
    alias Estore.Inventory.Review

    import Estore.InventoryFixtures

    @invalid_attrs %{comment: nil, rating: nil}

    test "list_reviews/0 returns all reviews" do
      review = review_fixture()
      assert Inventory.list_reviews() == [review]
    end

    test "get_review!/1 returns the review with given id" do
      review = review_fixture()
      assert Inventory.get_review!(review.id) == review
    end

    test "create_review/1 with valid data creates a review" do
      valid_attrs = %{comment: "some comment", rating: 42}

      assert {:ok, %Review{} = review} = Inventory.create_review(valid_attrs)
      assert review.comment == "some comment"
      assert review.rating == 42
    end

    test "create_review/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_review(@invalid_attrs)
    end

    test "update_review/2 with valid data updates the review" do
      review = review_fixture()
      update_attrs = %{comment: "some updated comment", rating: 43}

      assert {:ok, %Review{} = review} = Inventory.update_review(review, update_attrs)
      assert review.comment == "some updated comment"
      assert review.rating == 43
    end

    test "update_review/2 with invalid data returns error changeset" do
      review = review_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_review(review, @invalid_attrs)
      assert review == Inventory.get_review!(review.id)
    end

    test "delete_review/1 deletes the review" do
      review = review_fixture()
      assert {:ok, %Review{}} = Inventory.delete_review(review)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_review!(review.id) end
    end

    test "change_review/1 returns a review changeset" do
      review = review_fixture()
      assert %Ecto.Changeset{} = Inventory.change_review(review)
    end
  end
end


defmodule Estore.AcceptanceTest do
  # The Following functions have been tested and work
  use Estore. DataCase
  alias Estore.Repo
  alias Estore.Accounts
  alias Estore.Accounts.{User}
  alias Estore.Inventory
  alias Estore.Inventory.{Product, Subcategory, Tag, Image, Review}
  alias Estore.Orders

  @customer_attributes = %{}
  @product1_attributes = %{}
  @subcategory1_attributes = %{}
  @review1_attributes = %{}

  @invalid_attrs %{}


  describe "register_user/1" do
    test "requires email and password to be set" do
      {:error, changeset} = Accounts.register_user(%{})

      assert %{
               password: ["can't be blank"],
               email: ["can't be blank"]
             } = errors_on(changeset)
    end

    test "validates email and password when given" do
      {:error, changeset} = Accounts.register_user(%{email: "not valid", password: "not valid"})

      assert %{
               email: ["must have the @ sign and no spaces"],
               password: ["should be at least 12 character(s)"]
             } = errors_on(changeset)
    end

    test "validates maximum values for email and password for security" do
      too_long = String.duplicate("db", 100)
      {:error, changeset} = Accounts.register_user(%{email: too_long, password: too_long})
      assert "should be at most 160 character(s)" in errors_on(changeset).email
      assert "should be at most 72 character(s)" in errors_on(changeset).password
    end

    test "validates email uniqueness" do
      %{email: email} = user_fixture()
      {:error, changeset} = Accounts.register_user(%{email: email})
      assert "has already been taken" in errors_on(changeset).email

      # Now try with the upper cased email too, to check that email case is ignored.
      {:error, changeset} = Accounts.register_user(%{email: String.upcase(email)})
      assert "has already been taken" in errors_on(changeset).email
    end

    test "registers users with a hashed password" do
      email = unique_user_email()
      role_id = user_role()
      {:ok, user} = Accounts.register_user(valid_user_attributes(email: email, role_id: role_id))
      assert user.email == email
      assert user.role_id == role_id
      assert is_binary(user.hashed_password)
      assert is_nil(user.confirmed_at)
      assert is_nil(user.password)
    end
  end
  describe "acceptance" do
    test "The purchasing flow works", %{conn: conn} do
      {:ok, view, _html} = live(conn, "path")

    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Inventory.get_product!(product.id) == product
    end


    #  Begin
    test "create_subcategory/1 with valid data creates a subcategory" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Subcategory{} = subcategory} = Inventory.create_subcategory(valid_attrs)
      assert subcategory.title == "some title"
    end

    test "create_subcategory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_subcategory(@invalid_attrs)
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs =   %{
        handle: "some-handle",
        title: "some title",
        sku: 123456789123,
        body: "some body",
        vendor: "some vendor",
        category: "some category",
        published: true,
        size: "small",
        color: "some color",
        condition: "new",
        inventory_qty: 5,
        price: Decimal.new("120.5"),
        compare_at_price: Decimal.new("120.5"),
        subcategory_ids: [1],
        tags: [
          %{
            title: "fall",
            product_id: 1
            user_id: seller1
          },
          %{
            title: "gucci",
            product_id: 1,
            user_id: seller1
          },
        ],
        images: [
          %{
            image_src: "https://burst.shopifycdn.com/photos/mens-fall-fashion-jacket.jpg?width=925&exif=1&iptc=1/1",
            image_position: 1,
            image_alt_text: "Mens Fall Fashion Jacket",
            product_id: 1,
            user_id: seller1
          },
          %{
            image_src: "https://facebook.com",
            image_position: 2,
            image_alt_text: "The Jacket",
            product_id: 1,
            user_id: seller1
          }
        ],
        user_id: seller1
      },

      assert {:ok, %Product{} = product} = Inventory.create_product(valid_attrs)
      assert product.body == "some body"
      assert product.category == "some category"
      assert product.color == "some color"
      assert product.compare_at_price == Decimal.new("130.5")
      assert product.condition == "some condition"
      assert product.handle == "some handle"
      assert product.inventory_qty == 42
      assert product.price == Decimal.new("120.5")
      assert product.published == true
      assert product.size == "some size"
      assert product.sku == 42
      assert product.title == "some title"
      assert product.vendor == "some vendor"
      assert product.subcategory_ids: [%Subcategory{}]
      assert product.tags == [%Tag{},%Tag{}]
      assert product.images == [%Images{},%Images{}]
      assert product.user_id == %User{}
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_product(@invalid_attrs)
    end

    test "get_user_by_email/1 returns the user if the email exists" do
      %{id: id} = user = user_fixture()
      assert %User{id: ^id} = Accounts.get_user_by_email(user.email)
    end

    test "get_user_by_email/1 does not return the user if the email does not exist" do
      refute Accounts.get_user_by_email("unknown@example.com")
    end

    test "create_cart/1 with valid data creates a cart" do
      user = customer_fixture()
      assert {:ok, %Cart{} = cart} = ShoppingCart.create_cart(user)
      assert cart.user.role = 3
    end

    test "create_cart/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ShoppingCart.create_cart(@invalid_attrs)
    end

    test "add_item_to_cart/2 with valid data updates the cart" do
      cart = cart_fixture()
      product = product_fixture()

      assert {:ok, %Cart{} = cart} = ShoppingCart.add_item_to_cart(cart, product)
    end

    test "add_item_to_cart/2 with invalid data returns error changeset" do
      cart = cart_fixture()
      assert {:error, %Ecto.Changeset{}} = ShoppingCart.add_item_to_cart(cart, @invalid_attrs)
      assert cart == ShoppingCart.get_cart!(cart.id)
    end

    test "complete_order/1 with valid data creates a order" do
      cart = shopping_cart_fixture()
      # valid_attrs = %ShoppingCart.Cart{total_price: "120.5"}
      completed_order = order_fixture()

      assert {:ok, %Order{} = order} = Orders.complete_order(cart)
      # assert order.total_price == Decimal.new("120.5")
      assert order = compå
    end

    test "complete_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Orders.complete_order(@invalid_attrs)
    end
  end


  ############# Like create
  customer1 = Accounts.register_user(customer_attributes)
  # seller1 = Accounts.register_user(seller_attributes)
  # admin1 = Accounts.register_user(admin_attributes)

  subcategory1 = Inventory.create_subcategory(subcategory1_attributes)
  # A product should create tags, an image,
  product1 = Inventory.create_product(product1_attributes)
  # review1 = Inventory.create_review(review1_attributes)

  ############### Like Ge
  current_user = Accounts.get_user_by_email(customer1.email)
  # token = Accounts.get_user_by_session_token()
  # Accounts.confirm_user(token)
  # sign_in = Accounts.generate_user_session_token()



  cart = ShoppingCart.create_cart(customer1)

  ################# Like update
  # Custom
  ShoppingCart.add_item_to_cart(cart, product1)
  # ShoppingCart.add_item_to_cart(cart, product2)

  # Kinda Custom
  ########################## Like create
  order = Orders.complete_order(car)
end


# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Estore.Repo.insert!(%Estore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# At home
# 1. Run the changes and migrations
# 1a. User:role, Seller:approved(more of a frontend thing or required to insert product? V2
# Add datetime to reviews like getaway
# 2. Run the seeds.
alias Estore.Repo
alias Estore.Accounts
alias Estore.Inventory
alias Estore.Inventory.{Product, Subcategory, Tag, Image, Review}

for title <- ["Home Improment", "Men's Clothing", "Women's clothing", "Gardening", "Books"] do

  {:ok, _} = Inventory.create_subcategory(%{title: title})
end

for role <- ["customer", "seller", "admin"] do

  {:ok, _} = Accounts.create_role(%{title: role})
end

users = [
  %{
    full_name: "Adam Angel",
    email: "adam@gmail.com",
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
    role_id: 2,
    # products: [create_product1_cheaper]
  },
  %{
    full_name: "Angel Martinez Sanchez",
    email: "admin@user.com",
    role_id: 3,
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
  },
  %{
    full_name: "Nathaniel Jenkins",
    email: "admin@admin.com",
    role_id: 3,
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
  },
  %{
    full_name: "Seth Horsley",
    email: "seller@seller.com",
    role_id: 2,
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
  },
  %{
    full_name: "Danica Sebastion",
    email: "danica@user.com",
    role_id: 1,
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
  }
]

for user <- users do
  {:ok, _} = Estore.Accounts.register_user(user)
end

products = [
  %{
    handle: "mens-fall-jacket",
    title: "Men's Fall Jacket",
    sku: 100000000000,
    body: "Men's Fall Fashion Jacket ",
    vendor: "stylegucci",
    category: "apperal",
    published: true,
    size: "small",
    color: "red",
    condition: "new",
    inventory_qty: 5,
    price: Decimal.new("19.99"),
    compare_at_price: Decimal.new("39.99"),
    subcategory_ids: [1],
    tags: [
      %{
        title: "fall",
        product_id: 1,
        user_id: 1
      },
      %{
        title: "gucci",
        product_id: 1,
        user_id: 1
      },
    ],
    images: [
      %{
        image_src: "https://burst.shopifycdn.com/photos/mens-fall-fashion-jacket.jpg?width=925&exif=1&iptc=1/1",
        image_position: 1,
        image_alt_text: "Mens Fall Fashion Jacket",
        product_id: 1,
        user_id: 1
      },
      %{
        image_src: "https://facebook.com",
        image_position: 2,
        image_alt_text: "The Jacket",
        product_id: 1,
        user_id: 1
      }
    ],
    user_id: 1
  },
  %{
    handle: "mens-fall-jacket",
    title: "Men's Fall Jacket",
    sku: 100000000000,
    body: "Men's Fall Fashion Jacket ",
    vendor: "stylegucci",
    category: "apperal",
    published: true,
    size: "small",
    color: "red",
    condition: "new",
    inventory_qty: 5,
    price: Decimal.new("19.99"),
    compare_at_price: Decimal.new("39.99"),
    subcategory_ids: [1, 2, 3],
    tags: [
      %{
        title: "fall",
        product_id: 2,
        user_id: 2
      },
      %{
        title: "gucci",
        product_id: 2,
        user_id: 2
      },
    ],
    images: [
      %{
        image_src: "https://youtube.com",
        image_position: 1,
        image_alt_text: "Mens Fall Fashion Jacket",
        product_id: 2,
        user_id: 2
      },
      %{
        image_src: "https://twitter.com",
        image_position: 2,
        image_alt_text: "The Jacket",
        product_id: 2,
        user_id: 2
      }
    ],
    user_id: 2
  }
]

# Tip: Don't worry about how user, tags, or images, fields will be filled out. That's controller/frontend issues. Just make sure the data gets to the proper tables.

for product <- products do
  {:ok, _} = Inventory.create_product(product)
end


# # %Product{
# #   handle: "chain-bracelet",
# #   title: "7 Shakira Bracelet",
# #   body: "7 chakra bracelet, in blue or black.",
# #   vendor: "Company 123",
# #   category: "jewlrey",
# #   published: true,
# #   size: "" ,
# #   color: "navy",
# #   condition: "new",
# #   sku: 123456789123,
# #   inventory_qty: 1,
# #   price: Decimal.new("42.99"),
# #   compare_at_price: Decimal.new("64.99"),
# #   tags: [
# #     %Tag{title: "Chain"},
# #     %Tag{title: "Bracelet"}
# #   ],
# #   subcategories: [
# #     %Subcategory{title: "Bracelet"}
# #   ],
# #   images: [
# #     %Image {
# #       image_src: "https://burst.shopifycdn.com/photos/navy-blue-chakra-bracelet_925x.jpg",
# #       image_position: "1",
# #       image_alt_text: "7 chakra bracelet, in blue or black."
# #     }
# #   ],
# #   reviews: [
# #     %Review{
# #       rating: 5,
# #       comment: "Made me feel very pretty",
# #       user: "user@user.com",
# #       inserted_at: DateTime.from_naive!(~N[2019-03-26 22:00:00], "Etc/UTC")
# #     }
# #   ],
# #   user: seth
# # }
