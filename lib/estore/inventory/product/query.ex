# defmodule Estore.Inventory.Product.Query do
#   import Ecto.Query
#   alias Estore.Inventory.Product
#   # alias Pento.Survey.{Rating, Demographic}
#   # alias Pento.Accounts.User




#   query = from "products", select: [:title, :price]
#   # Repo.all(query)

#   select: T1.`sku`, T2.a, T2.b from
#    (select max(price) as price,`sku` from Table1 group by `sku`) T1
#   join: Table1 as T2 on T1.price=T2.price


#   query = from p in "products",
#   join: r in "reviews", on: p.review_id == r.id,
#   where: p.
#   select: %{product_name: p.title, product_price: p.price, review: p.rating}

#   query = from p in "products", select: %{product_name: p.title, product_price: p.price}
# end

# #################

# SELECT t.id, t.title, a.title
#   FROM tracks t
#   JOIN albums a ON t.album_id = a.id
#   WHERE t.duration > 900;

# # And here’s that same query written in Ecto:
# query = from t in "tracks",
# join: a in "albums", on: t.album_id == a.id, where: t.duration > 900,
# select: [t.id, t.title, a.title]


# # As a Macro
# query = "tracks"
# |> join(:inner, [t], a in "albums", on: t.album_id == a.id) |> where([t,a], t.duration > 900) # joined in where ([t, a])
# |> select([t,a], [t.id, t.title, a.title]) # Joined in [t, a]

# # Queries we need
# # Home Page
# # List a selection of products with unique names, from the cheapest sellers, with reviews, and also get their tags to add to the cache.
# # List all products with reviews(from customer on that product)
# #- Create proudct, then customer, then review

# # Product Page
# # Q: cheapest_item: query from user who is selling it the cheapest + new(only)
# # Q: show_product = query product(falljacketid) belonging to sellerand has reviews from users
# ### Will need to add a join for seller reviews when that's up.

# # Q: other_options_query = query products with same sku belonging to other "users" and sort by price.
# ## products(only show fall jacket) | users(only show users with fall jackets) => inner join
# ### Will need to add a join for seller reviews when that's up.

# SELECT Customers.CustomerName, Orders.OrderID
# FROM Customers
# LEFT JOIN Orders
# ON Customers.CustomerID=Orders.CustomerID
# ORDER BY Customers.CustomerName;

# defmodule Estore.Inventory.Product.Query do
# Repo.all  q = from p in "prdoucts",
#             left_join: t in "tags", on: p.id == t.product,
#             select: %{product_name: p.title, product_price: p.price, tag: t.title}
# end

# defmodule Estore.Inventory.Product.Query do
#   q = from p in "prdoucts",
#   join: r in "reviews", on: p.review_id == r.id,
#   where: p.
#   select: %{product_name: p.title, product_price: p.price, review: p.rating}
# end

# Repo.all from p in Post,
#            join: c in assoc(p, :comments),
#            join: l in assoc(c, :likes),
#            where: l.inserted_at > c.updated_at,
#            preload: [comments: {c, likes: l}]

# Repo.all from p in Product,
#           left_join: t in assoc(p, :tags),
#           where: p.id == t.id,
#           preload: [:tags]
#           select: %{product_name: p.title, product_price: p.price, product_tags: t.title},


# Repo.all from p in Product,
#             join: t in assoc(p, :tags),
#             where: p.id == 1,
#             preload: [tags: p],
#             select: %{product_name: p.title, product_price: p.price, product_tags: t.title}









# Comment
# |> join(:inner, [c], p in Post, on: c.post_id == p.id)
# |> select([c, p], {p.title, c.text})

# Post
# |> join(:left, [p], c in assoc(p, :comments))
# |> select([p, c], {p, c})

# Post
# |> join(:left, [p], c in Comment, on: c.post_id == p.id and c.is_visible == true)
# |> select([p, c], {p, c})
# #################
# # Google, where select options, how to get the largest constraint? to only show up if else in queries

# City |> order_by([c], asc: c.name, desc: c.population)  |||
# from(c in City, order_by: c.name, order_by: c.population) |||
# from(c in City, order_by: [asc: c.name, desc: c.population])

# query = from(p in Product, select: %{product_name: p.title, product_price: p.price}, order_by: [asc: p.price])
# from(p in Product, left_join: t in assoc(p, :tags) )

# Repo.all(
#   Product
#   |> join(:left, [p], t in Tag, on: t.product_id == p.id)
#   |> select([p, t], {p, t})
# )


# Post |> preload(:comments) |> select([p], p)

# query =
#   Post
#   |> join(:left, [p], c in assoc(p, :comments))
#   |> preload([p, c], [:user, comments: c])
#   |> select([p], p)
