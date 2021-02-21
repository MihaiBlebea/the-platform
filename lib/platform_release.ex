defmodule PlatformRelease do
    @app :platform

    @seed_file "seed.exs"

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

    defp repos do
        Application.fetch_env!(@app, :ecto_repos)
    end

    defp load_app do
        Application.load(@app)
    end

    @spec seed() :: list
    def seed() do
        load_app()

        for repo <- repos() do
            case Ecto.Migrator.with_repo(repo, &eval_seed(&1, @seed_file)) do
                {:ok, {:ok, _fun_return}, _apps} ->
                    :ok

                {:ok, {:error, reason}, _apps} ->
                    IO.warn(reason)
                    {:error, reason}

                {:error, term} ->
                    IO.warn(term, [])
                    {:error, term}
            end
        end
    end

    defp eval_seed(repo, filename) do
        seeds_file = get_path(repo, "seeds", filename)

        if File.regular?(seeds_file) do
            {:ok, Code.eval_file(seeds_file)}
        else
            {:error, "Seeds file not found."}
        end
    end

    defp get_path(repo, directory, filename) do
        priv_dir = "#{:code.priv_dir(@app)}"

        repo_underscore =
            repo
            |> Module.split()
            |> List.last()
            |> Macro.underscore()

        Path.join([priv_dir, repo_underscore, directory, filename])
    end
end
