defmodule EstoreWeb.CartView do
  use EstoreWeb, :view

  alias Estore.ShoppingCart

  def currency_to_str(%Decimal{} = val), do: "$#{Decimal.round(val, 2)}"
end
