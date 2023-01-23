defmodule Estore.Repo.Migrations.CreateUserRolesUsingPostgres do
  use Ecto.Migration

  def change do
#     drop table("roles")
#     execute("CREATE ROLE ADMIN")
#     execute("CREATE ROLE Seller")
#     execute("CREATE ROLE CUSTOMER")

#     execute("GRANT INSERT, SELECT, UPDATE, DELETE ON users TO ADMIN")
#     execute("GRANT INSERT, SELECT, UPDATE, DELETE ON users TO ADMIN")

  end
end



# execute("GRANT INSERT, SELECT, UPDATE, DELETE ON users TO STORE_ADMIN")
# execute("")
# execute("")
# GRANT INSERT, SELECT, UPDATE, DELETE ON users TO STORE_ADMIN
# GRANT INSERT, SELECT, UPDATE ON users TO STORE_ADMIN
# GRANT DELETE ON TABLE users TO joe WHERE id = current_user_id()



# GRANT INSERT, SELECT ON orders TO ORDER_SPECIALIST;
#        GRANT USAGE, SELECT ON SEQUENCE orders_order_id_seq TO ORDER_SPECIALIST

# GRANT SELECT ON orders TO CUSTOMER_SUPPORT
