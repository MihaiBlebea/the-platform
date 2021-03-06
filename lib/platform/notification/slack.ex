defmodule Platform.Slack do
    @spec send(map) :: :ok | :fail
    def send(payload) do
        url = Application.get_env(:platform, :slack_webhook)
        headers = ["Content-Type": "application/json"]
        body_content = Jason.encode!(payload)
        %{status_code: code, headers: _, body: _body} = HTTPoison.post!(url, body_content, headers)

        case code do
            200 -> :ok
            _ -> :fail
        end
    end

    @spec send_text(binary) :: :ok | :fail
    def send_text(text), do: __MODULE__.send(%{text: text})

    @spec contact_form(binary, binary, binary, binary) :: :fail | :ok
    def contact_form(name, email, phone, message) do
        %{
            blocks: [
                %{
                    type: "section",
                    text: %{
                        type: "plain_text",
                        text: ":wave: You got a new message from the contact form on The Platform website",
                        emoji: true
                    }
                },
                %{
                    type: "divider"
                },
                %{
                    type: "section",
                    fields: [
                        %{
                            type: "mrkdwn",
                            text: "*Name:*\n " <> name
                        },
                        %{
                            type: "mrkdwn",
                            text: ":email: *Email:*\n " <> email
                        },
                        %{
                            type: "mrkdwn",
                            text: "*Phone:*\n " <> phone
                        }
                    ]
                },
                %{
                    type: "header",
                    text: %{
                        type: "plain_text",
                        text: "Message:",
                        emoji: true
                    }
                },
                %{
                    type: "section",
                    text: %{
                        type: "plain_text",
                        text: message,
                        emoji: true
                    }
                }
            ]
        } |> send
    end
end
