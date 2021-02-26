defmodule Platform.ContactMessage do
    use Ecto.Schema

    import Ecto.{Changeset, Query}

    alias Platform.{Repo, ContactMessage, ReportHelper}

    @type t() :: %__MODULE__{}

    schema "contact_messages" do
        field :email, :string
        field :message, :string
        field :name, :string
        field :phone, :string

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(contact_message, attrs) do
        contact_message
        |> cast(attrs, [:name, :phone, :email, :message])
        |> validate_required([:name, :phone, :email, :message])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(contact_message) do
        changeset(%__MODULE__{}, contact_message)
        |> Repo.insert
    end

    @spec get_today() :: %{count: integer}
    def get_today() do
        {today_start, today_end} = ReportHelper.get_today_interval()

        messages =
            from(cm in ContactMessage, where: cm.inserted_at >= ^today_start and cm.inserted_at <= ^today_end)
            |> group_by([cm], fragment("DAY(?)", cm.inserted_at))
            |> select([cm], %{count: count(cm.id)})
            |> Repo.all
            |> List.first

        case messages do
            nil -> %{count: 0}
            messages -> messages
        end
    end
end
