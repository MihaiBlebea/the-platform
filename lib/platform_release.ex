defmodule PlatformRelease do
    @app :platform

    alias Platform.Article

    def migrate do
        load_app()

        for repo <- repos() do
            {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
        end
    end

    def rollback(repo, version) do
        load_app()
        {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
    end

    def seed() do
        load_app()
        for article <- articles(), do: article |> Article.save
    end

    defp repos do
        Application.fetch_env!(@app, :ecto_repos)
    end

    defp load_app do
        Application.load(@app)
    end

    defp articles() do
        "seed/articles.json"
        |> File.read!
        |> Jason.decode!
    end
end
