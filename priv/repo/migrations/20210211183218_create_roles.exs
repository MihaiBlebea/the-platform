defmodule Platform.Repo.Migrations.CreateRoles do
    use Ecto.Migration

    def change do
        create table(:roles) do
            add :title, :string
            add :label, :string
            add :active, :boolean, default: false, null: false

            timestamps()
        end
    end
end
