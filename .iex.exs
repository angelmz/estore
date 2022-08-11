import ExUnit.Assertions
import IEx.Helpers

alias Estore.Inventory
alias Estore.Inventory.{Product, Image, Subcategory, Tag, Review}
alias Estore.Accounts
alias Estore.Accounts.User
alias Estore.Repo

import_if_available Ecto.Query

import_if_available Ecto.Changeset

defmodule H do

  def update(schema, changes) do
    schema
    |> Ecto.Changeset.change(changes)
    |> Repo.update
  end

end
