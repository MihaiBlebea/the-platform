defmodule PlatformWeb.ComponentView do
    use PlatformWeb, :view


    @spec navigations(Plug.Conn.t()) :: [map]
    def navigations(conn) do
        default = [
            %{label: "Blog", url: "/#blog", scrollable: true},
            %{label: "About", url: "/#about", scrollable: true},
            %{label: "Contact", url: "/#contact", scrollable: true}
        ]

        case signed_in?(conn) do
            true ->
                default ++ [
                    %{label: "Member", url: "/member", scrollable: false},
                    %{label: "Logout", url: "/member/logout", scrollable: false}
                ]
            false ->
                default ++ [
                    %{label: "Register", url: "/member/register", scrollable: false},
                    %{label: "Login", url: "/member/login", scrollable: false}
                ]
        end
    end
end
