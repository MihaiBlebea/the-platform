defmodule Platform.Repo.Migrations.CreateTags do
    use Ecto.Migration

    def change do
        create table(:tags) do
            add :label, :string
            add :active, :boolean, default: false, null: false

            timestamps()
        end

    end
end
