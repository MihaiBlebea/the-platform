defmodule Platform.EmailMarketing do

    @spec subscribe(binary) :: :ok | :fail
    def subscribe(email) do
        url = "https://api.convertkit.com/v3/forms/#{ Application.get_env(:platform, :ck_form_id) }/subscribe"
        headers = ["Content-Type": "application/json"]
        payload = %{
            api_key: Application.get_env(:platform, :ck_api_key),
            email: email
        }
        body_content = Jason.encode!(payload)
        %{status_code: code, headers: _, body: _body} = HTTPoison.post!(url, body_content, headers)

        case code do
            200 -> :ok
            _ -> :fail
        end
    end
end
