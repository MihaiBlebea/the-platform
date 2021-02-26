defmodule Platform.Repo.Migrations.CreateSubscribers do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :email, :string
      add :url, :string
      add :form_id, :integer

      timestamps()
    end

  end
end
