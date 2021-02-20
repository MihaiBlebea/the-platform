defmodule Platform.Repo.Migrations.CreatePageViews do
    use Ecto.Migration

    def change do
        create table(:page_views) do
            add :url, :string

            timestamps()
        end

    end
end
