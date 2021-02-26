defmodule Platform.Subscriber do
    use Ecto.Schema

    import Ecto.{Changeset, Query}

    alias Platform.{Repo, Subscriber, ReportHelper}

    @type t() :: %__MODULE__{}

    schema "subscribers" do
        field :email, :string
        field :form_id, :integer
        field :url, :string

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(subscriber, attrs) do
        subscriber
        |> cast(attrs, [:email, :url, :form_id])
        |> validate_required([:email, :url, :form_id])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(role) do
        changeset(%__MODULE__{}, role)
        |> Repo.insert
    end

    @spec get_total_subscribers :: %{count: integer}
    def get_total_subscribers do
        from(s in Subscriber)
        |> select([s], %{count: count(s.id)})
        |> Repo.all
        |> List.first
    end

    @spec get_subscribers_today :: %{count: integer}
    def get_subscribers_today() do
        {today_start, today_end} = ReportHelper.get_today_interval()

        from(s in Subscriber, where: s.inserted_at >= ^today_start and s.inserted_at <= ^today_end)
        |> select([s], %{count: count(s.id)})
        |> Repo.all
        |> List.first
    end
end
