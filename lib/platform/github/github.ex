defmodule Platform.Github do

    @spec fetch_markdown_content(binary) :: binary
    def fetch_markdown_content(url) do
        %{body: body, status_code: code} = build_url(url) |> HTTPoison.get!
        case code do
            200 -> body
            _ -> nil
        end
    end

    defp build_url(url) do
        case Application.get_env(:platform, :github_token, nil) do
            nil -> url
            token -> url <> "?token=" <> token
        end
    end
end
