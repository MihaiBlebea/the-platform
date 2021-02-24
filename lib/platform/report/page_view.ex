defmodule Platform.PageView do
    use Ecto.Schema

    import Ecto.{Changeset, Query}

    alias Platform.{PageView, Repo, ReportHelper}

    @type t() :: %__MODULE__{}

    schema "page_views" do
        field :url, :string

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(page_view, attrs) do
        page_view
        |> cast(attrs, [:url])
        |> validate_required([:url])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(page_view) do
        changeset(%__MODULE__{}, page_view)
        |> Repo.insert
    end

    @spec all :: [] | [PageView.t()]
    def all(), do: Repo.all(__MODULE__)

    @spec get_by_date_interval(any, any) :: Ecto.Query.t()
    def get_by_date_interval(start_datetime, end_datetime) do
        from(pw in PageView, where: pw.inserted_at >= ^start_datetime and pw.inserted_at <= ^end_datetime)
        |> Repo.all
    end

    @spec all_count_by_day() :: [%{date: Date, count: integer}]
    def all_count_by_day() do
        from(pw in PageView)
        |> group_by([pw], fragment("DAY(?)", pw.inserted_at))
        |> select([pw], %{date: fragment("DATE(?)", pw.inserted_at), count: count(pw.id)})
        |> Repo.all
    end

    @spec get_top_pages_today :: [%{count: integer, url: binary}]
    def get_top_pages_today() do
        {today_start, today_end} = ReportHelper.get_today_interval()

        from(pw in PageView, where: pw.inserted_at >= ^today_start and pw.inserted_at <= ^today_end)
        |> group_by([pw], pw.url)
        |> order_by([pw], [desc: count(pw.id)])
        |> select([pw], %{url: pw.url, count: count(pw.id)})
        |> Repo.all
    end
end
