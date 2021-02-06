defmodule Platform.Tag do
    use Ecto.Schema
    import Ecto.Changeset

    schema "tags" do
        field :active, :boolean, default: false
        field :label, :string

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(tag, attrs) do
        tag
        |> cast(attrs, [:label, :active])
        |> validate_required([:label, :active])
    end
end
