defmodule Platform.Repo.Migrations.CreateUsers do
    use Ecto.Migration

    def change do
        create table(:users) do
            add :name, :string
            add :email, :string
            add :password, :string
            add :token, :text, null: true
            add :role_id, references(:roles)
            add :marketing_consent, :boolean, default: false, null: false

            timestamps()
        end
    end
end
