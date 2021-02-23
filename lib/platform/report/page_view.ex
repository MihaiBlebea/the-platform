defmodule Platform.PageView do
    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query

    alias Platform.Repo

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
        |> Platform.Repo.insert
    end

    @spec all :: [] | [Platform.PageView.t()]
    def all(), do: Repo.all(__MODULE__)

    @spec get_by_date_interval(any, any) :: Ecto.Query.t()
    def get_by_date_interval(start_datetime, end_datetime) do
        from(pw in Platform.PageView, where: pw.inserted_at >= ^start_datetime and pw.inserted_at <= ^end_datetime)
        |> Repo.all
    end

    @spec all_count_by_day() :: [%{date: Date, count: integer}]
    def all_count_by_day() do
        from(pw in Platform.PageView)
        |> group_by([e], fragment("DAY(?)", e.inserted_at))
        |> select([e], %{date: fragment("DATE(?)", e.inserted_at), count: count(e.id)})
        |> Repo.all
    end
end
