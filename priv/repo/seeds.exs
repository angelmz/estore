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
alias Estore.Accounts.User
alias Estore.Inventory.{Product, Subcategory, Tag, Image, Review}

  ## User registration

  # Registers a user.


  #     iex> register_user(%{field: value})
  #     {:ok, %User{}}

  #     iex> register_user(%{field: bad_value})
  #     {:error, %Ecto.Changeset{}}

  # def register_user(attrs) do
  #   %User{}
  #   |> User.registration_changeset(attrs)
  #   |> Repo.insert()
  # end

tag1 =
  %Tag{title: "Fall"}
  |> Repo.insert!

subcategory1 =
  %Subcategory{title: "men's apperal"}
  |> Repo.insert!

image1 =
  %Image {
    image_src: "https://burst.shopifycdn.com/photos/mens-fall-fashion-jacket.jpg?width=925&exif=1&iptc=1/1",
    image_position: 1,
    image_alt_text: "Mens Fall Fashion Jacket"
  }
  |> Repo.insert!

# user2 =
#   %User{
#     full_name: "Danica Sebastion",
#     email: "danica@user.com",
#     role: "customer",
#     password: "Hello world1!",
#     hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
#   }
#   |> Repo.insert!

# review1 =
#   %Review{
#     rating: 5,
#     comment: "Keeps me warm and it's stylish",
#     user: user2,
#     product: product1,
#     inserted_at: ~N[2022-01-01 23:00:07]
#   }
#   |> Repo.insert!

product1 =
  %Product{
    handle: "mens-fall-jacket",
    title: "Men's Fall Jacket",
    sku: 100000000000,
    body: "Mens Fall Fashion Jacket ",
    vendor: "stylegucci",
    category: "apperal",
    published: true,
    size: "small",
    color: "red",
    condition: "new",
    inventory_qty: 5,
    price: Decimal.new("19.99"),
    compare_at_price: Decimal.new("39.99"),
    tags: [
      tag1
    ],
    subcategories: [
      subcategory1
    ],
    images: [
      image1
    ],
  }
  |> Repo.insert!

#
# Users
#

Repo.insert(
  %User{
    full_name: "Angel Martinez Sanchez",
    email: "user@user.com",
    role: "customer",
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
  }
)

#
Repo.insert(
  %User{
    full_name: "Nathaniel Jenkins",
    email: "admin@admin.com",
    role: "admin",
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
  }
)

Repo.insert(
  %User{
    full_name: "Seth Horsley",
    email: "seller@seller.com",
    role: "seller",
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
    products: [product1]
  }
)

user2 =
  %User{
    full_name: "Danica Sebastion",
    email: "danica@user.com",
    role: "customer",
    password: "Hello world1!",
    hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
  }
  |> Repo.insert!


%Review{
  rating: 3,
  comment: "Keeps me warm and it's stylish",
  user: user2,
  product: product1,
  inserted_at: ~N[2022-01-01 23:00:07]
}
|> Repo.insert!


# it product just knows the user_id and reviews just
# knows the user_id and product_id
# because postgres, they're being inserted
# in a nested way?
# Seeds vs Tests

# %Product{
#   handle: "chain-bracelet",
#   title: "7 Shakira Bracelet",
#   body: "7 chakra bracelet, in blue or black.",
#   vendor: "Company 123",
#   category: "jewlrey",
#   published: true,
#   size: "" ,
#   color: "navy",
#   condition: "new",
#   sku: 123456789123,
#   inventory_qty: 1,
#   price: Decimal.new("42.99"),
#   compare_at_price: Decimal.new("64.99"),
#   tags: [
#     %Tag{title: "Chain"},
#     %Tag{title: "Bracelet"}
#   ],
#   subcategories: [
#     %Subcategory{title: "Bracelet"}
#   ],
#   images: [
#     %Image {
#       image_src: "https://burst.shopifycdn.com/photos/navy-blue-chakra-bracelet_925x.jpg",
#       image_position: "1",
#       image_alt_text: "7 chakra bracelet, in blue or black."
#     }
#   ],
#   reviews: [
#     %Review{
#       rating: 5,
#       comment: "Made me feel very pretty",
#       user: "user@user.com",
#       inserted_at: DateTime.from_naive!(~N[2019-03-26 22:00:00], "Etc/UTC")
#     }
#   ],
#   user: seth
# }
