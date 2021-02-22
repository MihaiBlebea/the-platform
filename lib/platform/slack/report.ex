defmodule Platform.Report do

    alias Platform.Slack

    def send_notification() do
        start_date = get_start_datetime()
        end_date = get_end_datetime()
        page_views = Platform.PageView.get_by_date_interval(start_date, end_date)
        Slack.send_text("#{page_views} ceva")

        Slack.page_view_report(%{
            start_date: NaiveDateTime.to_string(start_date),
            end_date: NaiveDateTime.to_string(end_date),
            total: length(page_views),
            top_pages: []
        })
    end

    defp get_end_datetime() do
        case DateTime.now("Etc/UTC") do
            {:error, _type} -> :fail
            {:ok, datetime} ->
                {:ok, native_datetime} = NaiveDateTime.new(datetime.year, datetime.month, datetime.day, 0, 0, 0)
                native_datetime
        end
    end

    defp get_start_datetime, do: get_end_datetime() |> NaiveDateTime.add(-1 * 60 * 60 * 24, :second)
end
