defmodule Platform.Role do
    use Ecto.Schema
    import Ecto.Changeset

    alias Platform.Repo

    @type t() :: %__MODULE__{}

    schema "roles" do
        field :active, :boolean, default: false
        field :title, :string
        field :label, :string

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(role, attrs) do
        role
        |> cast(attrs, [:title, :active, :label])
        |> validate_required([:title, :active, :label])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(role) do
        changeset(%__MODULE__{}, role)
        |> Repo.insert
    end

    @spec get_by_id(number) :: nil | __MODULE__.t()
    def get_by_id(id), do: Platform.Repo.get_by(__MODULE__, id: id)

    @spec get_by_label(atom) :: nil | __MODULE__.t()
    def get_by_label(label) when is_atom(label) do
        Platform.Repo.get_by(__MODULE__, label: Atom.to_string(label))
    end
end
