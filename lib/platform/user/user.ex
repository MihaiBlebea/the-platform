defmodule Platform.User do
    use Ecto.Schema
    import Ecto.Changeset

    @type t() :: %__MODULE__{}

    schema "users" do
        field :email, :string
        field :marketing_consent, :boolean, default: false
        field :name, :string
        field :password, :string
        field :role_id, :integer

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(user, attrs) do
        user
        |> cast(attrs, [:name, :email, :password, :marketing_consent, :role_id])
        |> validate_required([:name, :email, :password, :marketing_consent, :role_id])
        |> unique_constraint([:email])
        |> hash_password
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(user) do
        changeset(%__MODULE__{}, user)
        |> Platform.Repo.insert
    end

    @spec get_by_id(number) :: nil | __MODULE__.t()
    def get_by_id(id), do: Platform.Repo.get_by(__MODULE__, id: id)

    @spec get_by_id(binary) :: nil | __MODULE__.t()
    def get_by_email(email), do: Platform.Repo.get_by(__MODULE__, email: email)

    defp hash_password(%{valid?: false} = changeset), do: changeset

    defp hash_password(%{valid?: true} = changeset) do
        password =
            changeset
            |> get_field(:password)
            |> Bcrypt.hash_pwd_salt
        put_change(changeset, :password, password)
    end

    @spec is_password_valid?(__MODULE__.t(), binary) :: boolean
    def is_password_valid?(%__MODULE__{password: hash}, password) do
        Bcrypt.verify_pass(password, hash)
    end
end
