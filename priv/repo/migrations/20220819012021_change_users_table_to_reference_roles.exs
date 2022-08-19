defmodule Estore.Repo.Migrations.ChangeUsersTableToReferenceRoles do
  use Ecto.Migration

  def change do
    alter table("users") do
      remove :role, :string, null: false
      add :role_id, references(:roles, on_delete: :nothing), null: false
    end

    create index(:users, [:role_id])
  end

end
