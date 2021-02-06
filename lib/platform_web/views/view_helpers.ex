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
end
