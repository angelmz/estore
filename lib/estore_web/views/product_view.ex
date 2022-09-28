defmodule EstoreWeb.ProductView do
  use EstoreWeb, :view

  def subcategory_select(f, changeset) do
    existing_ids = changeset |> Ecto.Changeset.get_change(:subcategories, []) |> Enum.map(& &1.data.id)

    subcategory_opts =
      for subcat <- Estore.Inventory.list_subcategories(),
          do: [key: subcat.title, value: subcat.id, selected: subcat.id in existing_ids]

    multiple_select(f, :subcategory_ids, subcategory_opts)
  end
end
