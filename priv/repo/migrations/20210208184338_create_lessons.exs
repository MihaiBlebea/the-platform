defmodule Platform.Repo.Migrations.CreateLessons do
    use Ecto.Migration

    def change do
        create table(:lessons) do
            add :course_id, :integer
            add :title, :string
            add :video_url, :string
            add :content_url, :string
            add :slug, :string

            timestamps()
        end
    end
end
