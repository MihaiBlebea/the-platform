defmodule Platform.Repo.Migrations.CreateArticles do
    use Ecto.Migration

    def change do
        create table(:articles) do
            add :title, :string
            add :description, :string
            add :image_url, :string
            add :content_url, :string
            add :slug, :string
            add :active, :boolean

            timestamps()
        end

        create unique_index(:articles, [:slug])
    end
end
