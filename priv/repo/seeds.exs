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

      },
      %{
        title: "gucci",
      },
    ],
    images: [
      %{
        image_src: "https://burst.shopifycdn.com/photos/mens-fall-fashion-jacket.jpg?width=925&exif=1&iptc=1/1",
        image_position: 1,
        image_alt_text: "Mens Fall Fashion Jacket",
      },
      %{
        image_src: "https://facebook.com",
        image_position: 2,
        image_alt_text: "The Jacket",
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
      },
      %{
        title: "gucci",
      },
    ],
    images: [
      %{
        image_src: "https://youtube.com",
        image_position: 1,
        image_alt_text: "Mens Fall Fashion Jacket",
      },
      %{
        image_src: "https://twitter.com",
        image_position: 2,
        image_alt_text: "The Jacket",
      }
    ],
    user_id: 2
  }
]

# Tip: Don't worry about how user, tags, or images, fields will be filled out. That's controller/frontend issues. Just make sure the data gets to the proper tables.

seller = Accounts.get_user_by_email("seller@seller.com")

for product <- products do
  {:ok, _} = Inventory.create_product(seller, product)
end


####################
###IEX###
####################
Accounts.create_role(%{title: "seller"})
seth = %{
  full_name: "Seth Horsley",
  email: "seller@seller.com",
  role_id: 1,
  password: "Hello world1!",
  hashed_password: "$2b$12$Co5v5xpCAnFkBZDweag26.audmms4H2aO3rnDXdkgu8GBxwYcD8B2",
}
product1 = %{
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

    },
    %{
      title: "gucci",
    },
  ],
  images: [
    %{
      image_src: "https://burst.shopifycdn.com/photos/mens-fall-fashion-jacket.jpg?width=925&exif=1&iptc=1/1",
      image_position: 1,
      image_alt_text: "Mens Fall Fashion Jacket",
    },
    %{
      image_src: "https://facebook.com",
      image_position: 2,
      image_alt_text: "The Jacket",
    }
  ],
}

Inventory.create_subcategory(%{title: "Men's Clothing"})

{:ok, seller} = Accounts.register_user(seth)

get_seller = Accounts.get_user_by_email("seller@seller.com")

product1 = Inventory.create_product(get_seller, product1)



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
