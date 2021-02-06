defmodule PlatformWeb.PageView do
    use PlatformWeb, :view

    @spec download_cv_url :: binary
    def download_cv_url, do: Application.get_env(:platform, :download_cv_url)
end
