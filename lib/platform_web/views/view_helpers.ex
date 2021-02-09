defmodule PlatformWeb.ViewHelpers do

    alias Platform.User

    @spec render_component(binary, list) :: any
    def render_component(component, assigns \\ []) do
        Phoenix.View.render(PlatformWeb.ComponentView, component, assigns)
    end

    @spec to_html(nil | binary) :: nil | binary
    def to_html(nil), do: nil

    def to_html(content) do
        case Earmark.as_html(content, code_class_prefix: "code_") do
            {:ok, html_doc, []} -> Phoenix.HTML.raw html_doc
            {:error, _html_doc, _error_messages} -> nil
        end
    end

    @spec signed_in?(Plug.Conn.t()) :: false | true
    def signed_in?(conn) do
        user_id = Plug.Conn.get_session(conn, :auth_user_id)
        cond do
            user_id == nil -> false
            true -> !!User.get_by_id(user_id)
        end
    end

    @spec fetch_content(nil | binary) :: nil | binary
    def fetch_content(url) do
        {:ok, %{body: body, status_code: code}} = url |> HTTPoison.get
        case code do
            200 -> body
            _ -> nil
        end
    end

    def fetch_content(nil), do: nil

    @spec fetch_auth_user(Plug.Conn.t()) :: Platform.User.t()
    def fetch_auth_user(conn), do:  conn.assigns[:auth_user]

    @spec format_date(Date.t()) :: binary
    def format_date(date) do
        [date.year, date.month, date.day]
        |> Enum.map(&to_string/1)
        |> Enum.map(&String.pad_leading(&1, 2, "0"))
        |> Enum.join("-")
    end
end
