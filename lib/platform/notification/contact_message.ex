defmodule Platform.ContactMessage do
    use Ecto.Schema

    import Ecto.Changeset

    alias Platform.{Repo}

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
end
