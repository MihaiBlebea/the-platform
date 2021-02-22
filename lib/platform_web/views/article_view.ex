defmodule PlatformWeb.ArticleView do
    use PlatformWeb, :view

    alias Platform.{Article, Tag}

    @spec article_has_tag?(Article.t(), Tag.t()) :: boolean
    def article_has_tag?(article, tag), do: tag.id in (article.tags |> Enum.map(fn (tag) -> tag.id end))

    @spec is_set?(Article.t() | nil) :: false | true
    def is_set?(nil), do: false

    def is_set?(_article), do: true
end
