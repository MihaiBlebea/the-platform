defmodule PlatformWeb.ComponentView do
    use PlatformWeb, :view

    @spec navigations(Plug.Conn.t()) :: [map]
    def navigations(conn) do
        if signed_in?(conn) do
            case has_role?(conn, :admin) do
                true -> navigation_for_admin()
                false -> navigation_for_member()
            end
        else
            navigation_for_visitor()
        end
    end

    defp navigation_for_visitor() do
        [
            %{label: "Blog", url: "/#blog", scrollable: true},
            # %{label: "Courses", url: "/#courses", scrollable: true},
            %{label: "About", url: "/#about", scrollable: true},
            %{label: "Contact", url: "/#contact", scrollable: true},
            %{label: "Register", url: "/member/register", scrollable: false},
            %{label: "Login", url: "/member/login", scrollable: false}
        ]
    end

    defp navigation_for_admin() do
        [
            %{label: "Blog", url: "/#blog", scrollable: true},
            # %{label: "Courses", url: "/member", scrollable: false},
            %{label: "About", url: "/#about", scrollable: true},
            %{label: "Contact", url: "/#contact", scrollable: true},
            %{label: "Admin", url: "/admin", scrollable: false},
            %{label: "Logout", url: "/member/logout", scrollable: false}
        ]
    end

    defp navigation_for_member() do
        [
            %{label: "Blog", url: "/#blog", scrollable: true},
            # %{label: "Courses", url: "/member", scrollable: false},
            %{label: "About", url: "/#about", scrollable: true},
            %{label: "Contact", url: "/#contact", scrollable: true},
            %{label: "Logout", url: "/member/logout", scrollable: false}
        ]
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

    @spec footer_social_nav :: [%{icon_class: binary, url: binary}]
    def footer_social_nav() do
        [
            %{url: Application.get_env(:platform, :facebook_url), icon_class: "fab fa-fw fa-facebook-f"},
            %{url: Application.get_env(:platform, :twitter_url), icon_class: "fab fa-fw fa-twitter"},
            %{url: Application.get_env(:platform, :linkedin_url), icon_class: "fab fa-fw fa-linkedin-in"},
            %{url: Application.get_env(:platform, :github_url), icon_class: "fab fa-fw fa-github"}
        ]
    end
end
