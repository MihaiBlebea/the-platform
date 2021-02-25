defmodule Platform.Repo.Migrations.CreateContactMessages do
  use Ecto.Migration

  def change do
    create table(:contact_messages) do
      add :name, :string
      add :phone, :string
      add :email, :string
      add :message, :string

      timestamps()
    end

  end
end
