defmodule Mix.Tasks.Seed do
    use Mix.Task

    @shortdoc "Seeds the database with data from /seed folder"

    @moduledoc """
    Just a task to seed the database
    """

    @spec run(any) :: :ok | {:error, any}
    def run(_args) do
        PlatformRelease.seed(Elixir.Platform.Repo, "seeds.exs")
    end
end
