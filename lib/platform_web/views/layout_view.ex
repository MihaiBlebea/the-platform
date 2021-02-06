defmodule PlatformWeb.LayoutView do
    use PlatformWeb, :view

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
