defmodule PlatformWeb.MembershipView do
    use PlatformWeb, :view

    @spec lesson_slug(Platform.Course.t(), Platform.Lesson.t()) :: binary
    def lesson_slug(course, lesson), do: "/member/" <> course.slug <> "/" <> lesson.slug


    @spec active_lesson_slug?(Plug.Conn.t(), Platform.Course.t(), Platform.Lesson.t()) :: bool
    def active_lesson_slug?(conn, course, lesson), do: conn.request_path === lesson_slug(course, lesson)

    @spec last_lesson_url(Platform.Course.t(), [Platform.Lesson.t()], Platform.Lesson.t()) :: binary
    def last_lesson_url(course, lessons, lesson) do
        {_lesson, current_index} =
            lessons
            |> Enum.with_index
            |> Enum.filter(fn({value, _index}) ->
                value.id === lesson.id
            end)
            |> List.first

        case current_index do
            0 -> "/member"
            _index ->
                last_lesson = Enum.at(lessons, current_index - 1, 0)
                "/member/#{course.slug}/#{last_lesson.slug}"
        end
    end

    @spec next_lesson_url(Platform.Course.t(), [Platform.Lesson.t()], Platform.Lesson.t()) :: binary
    def next_lesson_url(course, lessons, lesson) do
        {_lesson, current_index} =
            lessons
            |> Enum.with_index
            |> Enum.filter(fn({value, _index}) ->
                value.id === lesson.id
            end)
            |> List.first

        cond do
            current_index === length(lessons) - 1 -> "/member"
            true ->
                next_lesson = Enum.at(lessons, current_index + 1, 0)
                "/member/#{course.slug}/#{next_lesson.slug}"
        end
    end
end
