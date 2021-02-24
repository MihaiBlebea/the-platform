defmodule Platform.ReportHelper do

    @spec today_start :: :fail | NaiveDateTime.t()
    def today_start() do
        case DateTime.now("Etc/UTC") do
            {:error, _type} -> :fail
            {:ok, datetime} ->
                {:ok, native_datetime} = NaiveDateTime.new(datetime.year, datetime.month, datetime.day, 0, 0, 0)
                native_datetime
        end
    end

    @spec get_today_interval :: {NaiveDateTime.t(), NaiveDateTime.t()}
    def get_today_interval do
        today_start = today_start()
        today_end = today_start |> NaiveDateTime.add(60 * 60 * 24 - 1, :second)

        {today_start, today_end}
    end
end
