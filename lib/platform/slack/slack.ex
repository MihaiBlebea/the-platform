defmodule Platform.Slack do
    @spec send_text(binary) :: :ok | :fail
    def send_text(text) do
        url = Application.get_env(:platform, :slack_webhook)
        headers = ["Content-Type": "application/json"]
        body_content = Jason.encode!(%{text: text})
        %{status_code: code, headers: _, body: _body} = HTTPoison.post!(url, body_content, headers)

        case code do
            200 -> :ok
            _ -> :fail
        end
    end
end
