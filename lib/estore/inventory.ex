defmodule Estore.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Estore.Repo

  alias Estore.Inventory.{Product, Subcategory, Tag, Image, Review}

  def list_products do
    Product |> Repo.all |> Repo.preload([:subcategories, :tags])
  end

  # change ids to attrs
  def get_product!(id) do
    Product |> Repo.get(id) |> Repo.preload([:subcategories, :tags])
  end

  def create_product(seller_id, attrs \\ %{}) do
    # tags = attrs[:tags]
    # images = attrs[:images]


    # for tag <- tags do
    #   {:ok, _} = Estore.Inventory.create_tag(seller, tag)
    # end

    # for image <- images do
    #   {:ok, _} = Estore.Inventory.create_image(seller, image)
    # end

    # To hit both users and products. You first create them, then grab them
    # grabed_images = images_by_user_id()
    # |> Ecto.Changeset.put_assoc(:images, grabbed_user_images)


    # %Product{}
    # |> Product.changeset(attrs)
    # |> Ecto.Changeset.put_assoc(:user, seller)
    # |> Ecto.Changeset.put_assoc(:tags, tags)
    # |> Ecto.Changeset.put_assoc(:images, images)
    # |> Repo.insert()


    %Product{user_id: seller_id}
    # |> Product.changeset(attrs)
    |> change_product(attrs)
    # |> Ecto.Changeset.cast(attrs, [])
    |> Ecto.Changeset.cast_assoc(:tags, with: &Tag.changeset/2)
    |> Ecto.Changeset.cast_assoc(:images, with: &Image.changeset/2)
    # |> IO.inspect()
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
    subcategories = list_subcategories_by_id(attrs["category_ids"])

    product
    |> Repo.preload(:subcategories)
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:subcategories, subcategories)

    # tags =
    #   Enum.map(attrs.tags, fn tag ->
    #     %{title: tag.title}
    #     |> Tag.changeset()
    #   end)

    # tags = [%Tags{},%Tags{}]
  #1.
    # images =
    #   Enum.map(attrs.images, fn image ->
    #     %{image_src: image.title, image_poistion: image.position, image_alt_text: image.image_alt_text}
    #     |> Image.changeset()
    #   end)
    #2. images should equal {%Image{}, %Image{}, etc.}
    #3. insert them or hope that they get inserted when the prdouct is created.
    # Images = Inventory.get_image_cluster([]) // Similar to get all images, but within a range

    # Inventory.create_tags

    # %Product{}
    # |> Product.changeset(attrs)

    # |> Ecto.Changeset.put_assoc(:user, seller)
    # |> Ecto.Changeset.put_assoc(:tags, [tags])
    # |> Ecto.Changeset.put_assoc(:images, [images])

    # |> Repo.insert()
    # |> case do
    #   {:ok, cart} -> {:ok, continue}
    #   {:error, changeset} -> {:error, exit_function_here() and have a screen for retry. }
    # end
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

  def create_tag(seller, attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    # |> Ecto.Changeset.put_assoc(:user, seller)
    |> Repo.insert()
  end

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

  # def get_image_by_seller_id!(seller) do
  #   Repo.get!(Image, id)
  # end


  def create_image(seller, attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    # |> Ecto.Changeset.put_assoc(:user, seller)
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
