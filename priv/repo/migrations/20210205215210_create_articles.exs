defmodule Platform.Repo.Migrations.CreateArticles do
    use Ecto.Migration

    def change do
        create table(:articles) do
            add :title, :string
            add :subtitle, :string
            add :description, :string
            add :image_url, :string
            add :content_url, :string
            add :slug, :string

            timestamps()
        end
    end
end
