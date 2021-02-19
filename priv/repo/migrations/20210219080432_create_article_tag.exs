defmodule Platform.Repo.Migrations.CreateArticleTag do
    use Ecto.Migration

    def change do
        create table(:article_tag, primary_key: false) do
            add(:article_id, references(:articles, on_delete: :delete_all), primary_key: true)
            add(:tag_id, references(:tags, on_delete: :delete_all), primary_key: true)

            timestamps()
        end

        create(index(:article_tag, [:article_id]))
        create(index(:article_tag, [:tag_id]))
    end

end
