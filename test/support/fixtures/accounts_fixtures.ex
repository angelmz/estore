defmodule Estore.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Estore.Accounts` context.
  """

  def unique_customer_email, do: "customer#{System.unique_integer()}@example.com"
  def unique_seller_email, do: "seller#{System.unique_integer()}@example.com"
  def unique_admin_email, do: "admin#{System.unique_integer()}@example.com"

  def unique_user_email, do: "user#{System.unique_integer()}@example.com"
  def user_role, do: Enum.random(1..3)

  def valid_password, do: "hello world!"

  # Just do a user fixtture with a random role 1-5
  # What would multiple tables look like?


  def valid_user_attributes(attrs \\ %{}) do
    Enum.into(attrs, %{
      full_name: "Danica Lee",
      role_id: user_role(),
      email: unique_user_email(),
      password: valid_password(),
      products: [],
      reviews: []
    })
  end

  # def valid_customer_attributes(attrs \\ %{}) do
  #   Enum.into(attrs, %{
  #     full_name: "Danica Lee",
  #     role_id: 1 ,
  #     email: unique_customer_email(),
  #     password: valid_password(),
  #     reviews: []
  #   })
  # end

  # def valid_seller_attributes(attrs \\ %{}) do
  #   Enum.into(attrs, %{
  #     full_name: "Seth Horsley",
  #     role: 2,
  #     email: unique_seller_email(),
  #     password: valid_password(),
  #     products: []
  #   })
  # end

  # def valid_admin_attributes(attrs \\ %{}) do
  #   Enum.into(attrs, %{
  #     full_name: "Nathaniel Jenkins",
  #     role: 2,
  #     email: unique_admin_email(),
  #     password: valid_password()
  #   })
  # end

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> valid_user_attributes()
      |> Estore.Accounts.register_user()

    user
  end

  # def customer_fixture(attrs \\ %{}) do
  #   {:ok, customer} =
  #     attrs
  #     |> valid_customer_attributes()
  #     |> Estore.Accounts.register_user()

  #   customer
  # end

  # def seller_fixture(attrs \\ %{}) do
  #   {:ok, seller} =
  #     attrs
  #     |> valid_seller_attributes()
  #     |> Estore.Accounts.register_user()

  #   seller
  # end

  # def admin_fixture(attrs \\ %{}) do
  #   {:ok, admin} =
  #     attrs
  #     |> valid_admin_attributes()
  #     |> Estore.Accounts.register_user()

  #   admin
  # end

  def extract_user_token(fun) do
    {:ok, captured_email} = fun.(&"[TOKEN]#{&1}[TOKEN]")
    [_, token | _] = String.split(captured_email.text_body, "[TOKEN]")
    token
  end
end
