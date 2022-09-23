defmodule Estore.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Estore.Repo

  alias Estore.Inventory.{Product, Subcategory, Tag, Image, Review}
  alias Estore.Accounts

  def list_products do
    Product |> Repo.all |> Repo.preload([:subcategories, :tags])
  end

  # change ids to attrs
  def get_product!(id) do
    Product |> Repo.get(id) |> Repo.preload([:subcategories, :tags])
  end

  def create_product(attrs \\ %{}) do
    %Product{}
    |> change_product(attrs)
    |> Repo.insert()
  end

  def update_product(%Product{} = product, attrs) do
    product
    |> change_product(attrs)
    |> Repo.update()
  end

  def delete_product(%Product{} = product) do
    Repo.delete(product)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product changes.

  ## Examples

      iex> change_product(product)
      %Ecto.Changeset{data: %Product{}}

  """
  def change_product(%Product{} = product, attrs \\ %{}) do
    subcategories = list_subcategories_by_id(attrs[:subcategory_ids])
    user = Accounts.get_user!(attrs[:user_id])
    # tags = attrs[:tags] # [%{title}]
    # images = attrs[:images]


    # create_tag(tags)
    # return images and Map.or enum.put user_id into from user variable

    product
    |> Repo.preload([:subcategories])
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:subcategories, subcategories)
    |> Ecto.Changeset.put_assoc(:user, user)

    # |> Ecto.Changeset.put_assoc(:tags, tags)
    # |> Ecto.Changeset.put_assoc(:images, images)
  end

  def complete_product(attrs \\ %{}) do
    complete_product = create_product(attrs)

    tags =
      Enum.map(complete_product.tags, fn tag ->
        %{title: tag.title, complete_product_id: complete_product.id, user_id: complete_product.user_id}
      end)

    images =
      Enum.map(complete_product.images, fn image ->
        %{title: image.title, complete_product_id: complete_product.id, user_id: complete_product.user_id}
      end)

    complete_product
    |>Ecto.Changeset.put_assoc(:tags, [tags])
    |>Ecto.Changeset.put_assoc(:images, [images])
    |> Product.changeset(attrs)
    |>Repo.insert()
  end

















###
# Subcategories
###

  def list_subcategories do
    Repo.all(Subcategory)
  end

  def list_subcategories_by_id(nil), do: []

  def list_subcategories_by_id(subcategory_ids) do
    Repo.all(from s in Subcategory, where: s.id in ^subcategory_ids)
  end

  def get_subcategory!(id), do: Repo.get!(Subcategory, id)

  def create_subcategory(attrs \\ %{}) do
    %Subcategory{}
    |> Subcategory.changeset(attrs)
    |> Repo.insert()
  end

  def update_subcategory(%Subcategory{} = subcategory, attrs) do
    subcategory
    |> Subcategory.changeset(attrs)
    |> Repo.update()
  end

  def delete_subcategory(%Subcategory{} = subcategory) do
    Repo.delete(subcategory)
  end

  def change_subcategory(%Subcategory{} = subcategory, attrs \\ %{}) do
    Subcategory.changeset(subcategory, attrs)
  end

  def list_tags do
    Repo.all(Tag)
  end

  def list_tags_by_id(nil), do: []

  def list_tags_by_id(tag_ids) do
    Repo.all(from t in Tag, where: t.id in ^tag_ids)
  end

  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  # create_tag(product = %Product{}, ){
  #   product_id = product.id
  #   user_id = product_user.id
  # }
  # def create_tag(%Product{} = product) do
  #   %Tag{}
  #   |> Tag.changeset(attrs)
  #   |> Repo.insert()
  # end

  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  def list_images do
    Repo.all(Image)
  end

  def get_image!(id), do: Repo.get!(Image, id)

  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  def change_image(%Image{} = image, attrs \\ %{}) do
    Image.changeset(image, attrs)
  end

  def list_reviews do
    Repo.all(Review)
  end

  def get_review!(id), do: Repo.get!(Review, id)

  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  def change_review(%Review{} = review, attrs \\ %{}) do
    Review.changeset(review, attrs)
  end
end
