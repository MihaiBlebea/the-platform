defmodule PlatformWeb.MembershipView do
    use PlatformWeb, :view

    def lesson_slug(course, lesson), do: "/member/" <> course.slug <> "/" <> lesson.slug

    def active_lesson_slug?(conn, course, lesson), do: conn.request_path === lesson_slug(course, lesson)
end
