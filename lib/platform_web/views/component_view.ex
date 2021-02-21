defmodule PlatformWeb.ComponentView do
    use PlatformWeb, :view


    @spec navigations(Plug.Conn.t()) :: [map]
    def navigations(conn) do
        default = [
            %{label: "Blog", url: "/#blog", scrollable: true}
        ]

        case signed_in?(conn) do
            true ->
                default ++ [
                    %{label: "Courses", url: "/member", scrollable: false},
                    %{label: "About", url: "/#about", scrollable: true},
                    %{label: "Contact", url: "/#contact", scrollable: true},
                    %{label: "Logout", url: "/member/logout", scrollable: false}
                ]
            false ->
                default ++ [
                    %{label: "Courses", url: "/#courses", scrollable: true},
                    %{label: "About", url: "/#about", scrollable: true},
                    %{label: "Contact", url: "/#contact", scrollable: true},
                    %{label: "Register", url: "/member/register", scrollable: false},
                    %{label: "Login", url: "/member/login", scrollable: false}
                ]
        end
    end

    @spec text_color(any) :: binary
    def text_color(theme) do
        case theme === :dark do
            true -> "text-secondary"
            false -> "text-light"
        end
    end

    @spec divider_color(any) :: nil | binary
    def divider_color(theme) do
        case theme === :dark do
            true -> nil
            false -> "divider-light"
        end
    end
end
