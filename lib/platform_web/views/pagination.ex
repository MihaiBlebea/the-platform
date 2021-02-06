defmodule PlatformWeb.Pagination do

    @moduledoc "This module handles the pagination concern for the blog"

    @type pagination_meta :: %{current_page: integer, total_pages: integer, prev_page: integer | nil, next_page: integer | nil}

    @spec are_pagination_params(list, integer, integer) :: any
    defguard are_pagination_params(content, per_page, current_page)
        when is_list(content) and is_number(per_page) and is_number(current_page)

    @spec paginate(list, integer, integer) :: pagination_meta
    def paginate(content, per_page, current_page) when are_pagination_params(content, per_page, current_page) do
        total_pages = content |> get_total_pages(per_page)

        cond do
            current_page == total_pages -> %{current_page: current_page, total_pages: total_pages, prev_page: (current_page - 1), next_page: nil}
            current_page == 1 -> %{current_page: current_page, total_pages: total_pages, prev_page: nil, next_page: (current_page + 1)}
            true -> %{current_page: current_page, total_pages: total_pages, prev_page: (current_page - 1), next_page: (current_page + 1)}
        end
    end

    @spec get_total_pages([any], number) :: number
    def get_total_pages(content, per_page) when is_list(content) and is_number(per_page) , do: length(content) / per_page |> ceil

    @spec get_current_page(%{query_params: map}) :: integer
    def get_current_page(%{query_params: %{"page" => ""}}), do: 1

    def get_current_page(%{query_params: %{"page" => page}}) when is_binary(page) do
        case Integer.parse(page) do
            {page_int, ""} -> page_int
            :error -> 1
        end
    end

    def get_current_page(%{query_params: %{"page" => page}}) when is_integer(page), do: page

    def get_current_page(%{query_params: _params}), do: 1
end
