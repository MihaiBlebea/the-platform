defmodule Platform.Repo.Migrations.CreateCourses do
    use Ecto.Migration

    def change do
        create table(:courses) do
            add :title, :string
            add :slug, :string
            add :description, :string

            timestamps()
        end

    end
end
