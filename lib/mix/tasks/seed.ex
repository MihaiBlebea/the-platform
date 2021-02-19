defmodule Mix.Tasks.Seed do
    use Mix.Task

    @shortdoc "Seeds the database with data from /seed folder"

    @moduledoc """
    Just a task to seed the database
    """

    def run(args) do
        IO.inspect args
        Application.ensure_all_started(:platform)

        Mix.shell().info("Seeding tables " <> Enum.join(args, ", "))

        for table <- args do
            case table do
                "articles" -> for article <- articles(), do: article |> Platform.Article.save
                "tags" -> for tag <- tags(), do: tag |> Platform.Tag.save
                "article_tag" -> for article_tag <- article_tags(), do: article_tag |> Platform.ArticleTag.save
                "courses" -> for course <- courses(), do: course |> Platform.Course.save
                "lessons" -> for lesson <- lessons(), do: lesson |> Platform.Lesson.save
                "users" -> for user <- users(), do: user |> Platform.User.save
                "roles" -> for role <- roles(), do: role |> Platform.Role.save
            end
            Mix.shell().info("Table " <> table <> " seeded")
        end
    end

    defp articles() do
        "seed/articles.json"
        |> File.read!
        |> Jason.decode!
    end

    defp tags() do
        "seed/tags.json"
        |> File.read!
        |> Jason.decode!
    end

    defp article_tags() do
        "seed/article_tags.json"
        |> File.read!
        |> Jason.decode!
    end

    defp courses() do
        "seed/courses.json"
        |> File.read!
        |> Jason.decode!
    end

    defp lessons() do
        "seed/lessons.json"
        |> File.read!
        |> Jason.decode!
    end

    defp users() do
        "seed/users.json"
        |> File.read!
        |> Jason.decode!
    end

    defp roles() do
        "seed/roles.json"
        |> File.read!
        |> Jason.decode!
    end
end
