defmodule Platform.Lesson do
    use Ecto.Schema
    import Ecto.Changeset
    import Ecto.Query

    alias Platform.Repo

    @type t() :: %__MODULE__{}

    schema "lessons" do
        field :course_id, :integer
        field :content_url, :string
        field :slug, :string
        field :title, :string
        field :video_url, :string

        timestamps()
    end

    @spec changeset(map, map) :: Ecto.Changeset.t()
    @doc false
    def changeset(lesson, attrs) do
        lesson
        |> cast(attrs, [:course_id, :title, :video_url, :content_url, :slug])
        |> validate_required([:course_id, :title, :video_url, :content_url, :slug])
    end

    @spec save(map) :: {:ok, __MODULE__.t()} | {:error, any}
    def save(lesson) do
        changeset(%__MODULE__{}, lesson)
        |> Repo.insert
    end

    @spec get_by_slug_and_course_id(binary, integer) :: nil | Platform.Lesson.t()
    def get_by_slug_and_course_id(slug, course_id) do
        Repo.get_by(__MODULE__, slug: slug, course_id: course_id)
    end

    @spec get_by_course_id(any) :: nil | [Platform.Lesson.t()]
    def get_by_course_id(course_id) do
        Repo.all from l in Platform.Lesson, where: l.course_id == ^course_id
    end
end
