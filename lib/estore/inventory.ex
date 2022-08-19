defmodule Estore.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias Estore.Repo

  alias Estore.Inventory.{Product, Subcategory, Tag, Image, Review}
  alias Estore.Accounts

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
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

  @doc """
  Deletes a product.

  ## Examples

      iex> delete_product(product)
      {:ok, %Product{}}

      iex> delete_product(product)
      {:error, %Ecto.Changeset{}}

  """
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
    tags = attrs[:tags] # [%{title}]
    images = attrs[:images]
    # return images and Map.or enum.put user_id into from user variable

    product
    |> Repo.preload([:subcategories])
    |> Product.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:subcategories, subcategories)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Ecto.Changeset.put_assoc(:tags, tags)
    |> Ecto.Changeset.put_assoc(:images, images)
  end

  @doc """
  Returns the list of subcategories.

  ## Examples

      iex> list_subcategories()
      [%Subcategory{}, ...]

  """

  def list_subcategories do
    Repo.all(Subcategory)
  end

  def list_subcategories_by_id(nil), do: []

  def list_subcategories_by_id(subcategory_ids) do
    Repo.all(from s in Subcategory, where: s.id in ^subcategory_ids)
  end

  @doc """
  Gets a single subcategory.

  Raises `Ecto.NoResultsError` if the Subcategory does not exist.

  ## Examples

      iex> get_subcategory!(123)
      %Subcategory{}

      iex> get_subcategory!(456)
      ** (Ecto.NoResultsError)

  """
  def get_subcategory!(id), do: Repo.get!(Subcategory, id)

  @doc """
  Creates a subcategory.

  ## Examples

      iex> create_subcategory(%{field: value})
      {:ok, %Subcategory{}}

      iex> create_subcategory(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_subcategory(attrs \\ %{}) do
    %Subcategory{}
    |> Subcategory.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a subcategory.

  ## Examples

      iex> update_subcategory(subcategory, %{field: new_value})
      {:ok, %Subcategory{}}

      iex> update_subcategory(subcategory, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_subcategory(%Subcategory{} = subcategory, attrs) do
    subcategory
    |> Subcategory.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a subcategory.

  ## Examples

      iex> delete_subcategory(subcategory)
      {:ok, %Subcategory{}}

      iex> delete_subcategory(subcategory)
      {:error, %Ecto.Changeset{}}

  """
  def delete_subcategory(%Subcategory{} = subcategory) do
    Repo.delete(subcategory)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking subcategory changes.

  ## Examples

      iex> change_subcategory(subcategory)
      %Ecto.Changeset{data: %Subcategory{}}

  """
  def change_subcategory(%Subcategory{} = subcategory, attrs \\ %{}) do
    Subcategory.changeset(subcategory, attrs)
  end

  @doc """
  Returns the list of tags.

  ## Examples

      iex> list_tags()
      [%Tag{}, ...]

  """

  def list_tags do
    Repo.all(Tag)
  end

  def list_tags_by_id(nil), do: []

  def list_tags_by_id(tag_ids) do
    Repo.all(from t in Tag, where: t.id in ^tag_ids)
  end
  @doc """
  Gets a single tag.

  Raises `Ecto.NoResultsError` if the Tag does not exist.

  ## Examples

      iex> get_tag!(123)
      %Tag{}

      iex> get_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tag!(id), do: Repo.get!(Tag, id)

  @doc """
  Creates a tag.

  ## Examples

      iex> create_tag(%{field: value})
      {:ok, %Tag{}}

      iex> create_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tag.

  ## Examples

      iex> update_tag(tag, %{field: new_value})
      {:ok, %Tag{}}

      iex> update_tag(tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tag(%Tag{} = tag, attrs) do
    tag
    |> Tag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tag.

  ## Examples

      iex> delete_tag(tag)
      {:ok, %Tag{}}

      iex> delete_tag(tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tag(%Tag{} = tag) do
    Repo.delete(tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tag changes.

  ## Examples

      iex> change_tag(tag)
      %Ecto.Changeset{data: %Tag{}}

  """
  def change_tag(%Tag{} = tag, attrs \\ %{}) do
    Tag.changeset(tag, attrs)
  end

  @doc """
  Returns the list of images.

  ## Examples

      iex> list_images()
      [%Image{}, ...]

  """
  def list_images do
    Repo.all(Image)
  end

  @doc """
  Gets a single image.

  Raises `Ecto.NoResultsError` if the Image does not exist.

  ## Examples

      iex> get_image!(123)
      %Image{}

      iex> get_image!(456)
      ** (Ecto.NoResultsError)

  """
  def get_image!(id), do: Repo.get!(Image, id)

  @doc """
  Creates a image.

  ## Examples

      iex> create_image(%{field: value})
      {:ok, %Image{}}

      iex> create_image(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_image(attrs \\ %{}) do
    %Image{}
    |> Image.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a image.

  ## Examples

      iex> update_image(image, %{field: new_value})
      {:ok, %Image{}}

      iex> update_image(image, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_image(%Image{} = image, attrs) do
    image
    |> Image.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a image.

  ## Examples

      iex> delete_image(image)
      {:ok, %Image{}}

      iex> delete_image(image)
      {:error, %Ecto.Changeset{}}

  """
  def delete_image(%Image{} = image) do
    Repo.delete(image)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking image changes.

  ## Examples

      iex> change_image(image)
      %Ecto.Changeset{data: %Image{}}

  """
  def change_image(%Image{} = image, attrs \\ %{}) do
    Image.changeset(image, attrs)
  end

  @doc """
  Returns the list of reviews.

  ## Examples

      iex> list_reviews()
      [%Review{}, ...]

  """
  def list_reviews do
    Repo.all(Review)
  end

  @doc """
  Gets a single review.

  Raises `Ecto.NoResultsError` if the Review does not exist.

  ## Examples

      iex> get_review!(123)
      %Review{}

      iex> get_review!(456)
      ** (Ecto.NoResultsError)

  """
  def get_review!(id), do: Repo.get!(Review, id)

  @doc """
  Creates a review.

  ## Examples

      iex> create_review(%{field: value})
      {:ok, %Review{}}

      iex> create_review(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_review(attrs \\ %{}) do
    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a review.

  ## Examples

      iex> update_review(review, %{field: new_value})
      {:ok, %Review{}}

      iex> update_review(review, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_review(%Review{} = review, attrs) do
    review
    |> Review.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a review.

  ## Examples

      iex> delete_review(review)
      {:ok, %Review{}}

      iex> delete_review(review)
      {:error, %Ecto.Changeset{}}

  """
  def delete_review(%Review{} = review) do
    Repo.delete(review)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking review changes.

  ## Examples

      iex> change_review(review)
      %Ecto.Changeset{data: %Review{}}

  """
  def change_review(%Review{} = review, attrs \\ %{}) do
    Review.changeset(review, attrs)
  end
end
