defmodule Estore.InventoryTest do
  use Estore.DataCase

  alias Estore.Inventory

  describe "products" do
    alias Estore.Inventory.Product

    import Estore.InventoryFixtures

    @invalid_attrs %{body: nil, category: nil, color: nil, compare_at_price: nil, condition: nil, handle: nil, inventory_qty: nil, price: nil, published: nil, size: nil, sku: nil, title: nil, vendor: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Inventory.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Inventory.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{body: "some body", category: "some category", color: "some color", compare_at_price: "120.5", condition: "some condition", handle: "some handle", inventory_qty: 42, price: "120.5", published: true, size: "some size", sku: 42, title: "some title", vendor: "some vendor"}

      assert {:ok, %Product{} = product} = Inventory.create_product(valid_attrs)
      assert product.body == "some body"
      assert product.category == "some category"
      assert product.color == "some color"
      assert product.compare_at_price == Decimal.new("120.5")
      assert product.condition == "some condition"
      assert product.handle == "some handle"
      assert product.inventory_qty == 42
      assert product.price == Decimal.new("120.5")
      assert product.published == true
      assert product.size == "some size"
      assert product.sku == 42
      assert product.title == "some title"
      assert product.vendor == "some vendor"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{body: "some updated body", category: "some updated category", color: "some updated color", compare_at_price: "456.7", condition: "some updated condition", handle: "some updated handle", inventory_qty: 43, price: "456.7", published: false, size: "some updated size", sku: 43, title: "some updated title", vendor: "some updated vendor"}

      assert {:ok, %Product{} = product} = Inventory.update_product(product, update_attrs)
      assert product.body == "some updated body"
      assert product.category == "some updated category"
      assert product.color == "some updated color"
      assert product.compare_at_price == Decimal.new("456.7")
      assert product.condition == "some updated condition"
      assert product.handle == "some updated handle"
      assert product.inventory_qty == 43
      assert product.price == Decimal.new("456.7")
      assert product.published == false
      assert product.size == "some updated size"
      assert product.sku == 43
      assert product.title == "some updated title"
      assert product.vendor == "some updated vendor"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_product(product, @invalid_attrs)
      assert product == Inventory.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Inventory.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Inventory.change_product(product)
    end
  end

  describe "subcategories" do
    alias Estore.Inventory.Subcategory

    import Estore.InventoryFixtures

    @invalid_attrs %{title: nil}

    test "list_subcategories/0 returns all subcategories" do
      subcategory = subcategory_fixture()
      assert Inventory.list_subcategories() == [subcategory]
    end

    test "get_subcategory!/1 returns the subcategory with given id" do
      subcategory = subcategory_fixture()
      assert Inventory.get_subcategory!(subcategory.id) == subcategory
    end

    test "create_subcategory/1 with valid data creates a subcategory" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Subcategory{} = subcategory} = Inventory.create_subcategory(valid_attrs)
      assert subcategory.title == "some title"
    end

    test "create_subcategory/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_subcategory(@invalid_attrs)
    end

    test "update_subcategory/2 with valid data updates the subcategory" do
      subcategory = subcategory_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Subcategory{} = subcategory} = Inventory.update_subcategory(subcategory, update_attrs)
      assert subcategory.title == "some updated title"
    end

    test "update_subcategory/2 with invalid data returns error changeset" do
      subcategory = subcategory_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_subcategory(subcategory, @invalid_attrs)
      assert subcategory == Inventory.get_subcategory!(subcategory.id)
    end

    test "delete_subcategory/1 deletes the subcategory" do
      subcategory = subcategory_fixture()
      assert {:ok, %Subcategory{}} = Inventory.delete_subcategory(subcategory)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_subcategory!(subcategory.id) end
    end

    test "change_subcategory/1 returns a subcategory changeset" do
      subcategory = subcategory_fixture()
      assert %Ecto.Changeset{} = Inventory.change_subcategory(subcategory)
    end
  end

  describe "tags" do
    alias Estore.Inventory.Tag

    import Estore.InventoryFixtures

    @invalid_attrs %{title: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Inventory.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Inventory.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Tag{} = tag} = Inventory.create_tag(valid_attrs)
      assert tag.title == "some title"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Tag{} = tag} = Inventory.update_tag(tag, update_attrs)
      assert tag.title == "some updated title"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_tag(tag, @invalid_attrs)
      assert tag == Inventory.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Inventory.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Inventory.change_tag(tag)
    end
  end

  describe "images" do
    alias Estore.Inventory.Image

    import Estore.InventoryFixtures

    @invalid_attrs %{image_alt_text: nil, image_position: nil, image_src: nil}

    test "list_images/0 returns all images" do
      image = image_fixture()
      assert Inventory.list_images() == [image]
    end

    test "get_image!/1 returns the image with given id" do
      image = image_fixture()
      assert Inventory.get_image!(image.id) == image
    end

    test "create_image/1 with valid data creates a image" do
      valid_attrs = %{image_alt_text: "some image_alt_text", image_position: 42, image_src: "some image_src"}

      assert {:ok, %Image{} = image} = Inventory.create_image(valid_attrs)
      assert image.image_alt_text == "some image_alt_text"
      assert image.image_position == 42
      assert image.image_src == "some image_src"
    end

    test "create_image/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Inventory.create_image(@invalid_attrs)
    end

    test "update_image/2 with valid data updates the image" do
      image = image_fixture()
      update_attrs = %{image_alt_text: "some updated image_alt_text", image_position: 43, image_src: "some updated image_src"}

      assert {:ok, %Image{} = image} = Inventory.update_image(image, update_attrs)
      assert image.image_alt_text == "some updated image_alt_text"
      assert image.image_position == 43
      assert image.image_src == "some updated image_src"
    end

    test "update_image/2 with invalid data returns error changeset" do
      image = image_fixture()
      assert {:error, %Ecto.Changeset{}} = Inventory.update_image(image, @invalid_attrs)
      assert image == Inventory.get_image!(image.id)
    end

    test "delete_image/1 deletes the image" do
      image = image_fixture()
      assert {:ok, %Image{}} = Inventory.delete_image(image)
      assert_raise Ecto.NoResultsError, fn -> Inventory.get_image!(image.id) end
    end

    test "change_image/1 returns a image changeset" do
      image = image_fixture()
      assert %Ecto.Changeset{} = Inventory.change_image(image)
    end
  end

  # describe "reviews" do
  #   alias Estore.Inventory.Review

  #   import Estore.InventoryFixtures

  #   @invalid_attrs %{comment: nil, rating: nil}

  #   test "list_reviews/0 returns all reviews" do
  #     review = review_fixture()
  #     assert Inventory.list_reviews() == [review]
  #   end

  #   test "get_review!/1 returns the review with given id" do
  #     review = review_fixture()
  #     assert Inventory.get_review!(review.id) == review
  #   end

  #   test "create_review/1 with valid data creates a review" do
  #     valid_attrs = %{comment: "some comment", rating: 42}

  #     assert {:ok, %Review{} = review} = Inventory.create_review(valid_attrs)
  #     assert review.comment == "some comment"
  #     assert review.rating == 42
  #   end

  #   test "create_review/1 with invalid data returns error changeset" do
  #     assert {:error, %Ecto.Changeset{}} = Inventory.create_review(@invalid_attrs)
  #   end

  #   test "update_review/2 with valid data updates the review" do
  #     review = review_fixture()
  #     update_attrs = %{comment: "some updated comment", rating: 43}

  #     assert {:ok, %Review{} = review} = Inventory.update_review(review, update_attrs)
  #     assert review.comment == "some updated comment"
  #     assert review.rating == 43
  #   end

  #   test "update_review/2 with invalid data returns error changeset" do
  #     review = review_fixture()
  #     assert {:error, %Ecto.Changeset{}} = Inventory.update_review(review, @invalid_attrs)
  #     assert review == Inventory.get_review!(review.id)
  #   end

  #   test "delete_review/1 deletes the review" do
  #     review = review_fixture()
  #     assert {:ok, %Review{}} = Inventory.delete_review(review)
  #     assert_raise Ecto.NoResultsError, fn -> Inventory.get_review!(review.id) end
  #   end

  #   test "change_review/1 returns a review changeset" do
  #     review = review_fixture()
  #     assert %Ecto.Changeset{} = Inventory.change_review(review)
  #   end
  # end
end
