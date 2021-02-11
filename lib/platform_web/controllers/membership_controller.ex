defmodule PlatformWeb.MembershipController do
    use PlatformWeb, :controller

    alias Platform.User

    alias Platform.Course

    alias Platform.Lesson

    plug :check_auth when action in [:index, :get_course, :get_lesson]

    defp check_auth(conn, _args) do
        if user_id = get_session(conn, :auth_user_id) do
            auth_user = User.get_by_id(user_id)

            case auth_user do
                nil ->
                    conn
                    |> put_flash(:error, "You need to be signed in to access this page")
                    |> redirect(to: "/member/login")
                    |> halt()
                user -> conn |> assign(:auth_user, user)
            end
        else
            conn
            |> put_flash(:error, "You need to be signed in to access this page")
            |> redirect(to: "/member/login")
            |> halt()
        end
    end

    @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
    def index(conn, _params) do
        courses = Course.all()

        conn |> render("index.html",
            [
                title: "Welcome to your membership area",
                subtitle: "Serban Blebea",
                courses: courses
            ]
        )
    end

    @spec get_register(Plug.Conn.t(), any) :: Plug.Conn.t()
    def get_register(conn, _params) do
        conn |> render("register.html", token: get_csrf_token())
    end

    @spec post_register(Plug.Conn.t(), any) :: Plug.Conn.t()
    def post_register(conn, %{
        "email" => email,
        "name" => name,
        "password" => password,
        "password-confirm" => password_confirm
    }) do
        if password !== password_confirm do
            conn |> redirect(to: conn.request_path)
        end
        case User.save(%{name: name, email: email, password: password}) do
            {:ok, user} ->
                conn
                |> put_session(:auth_user_id, user.id)
                |> put_flash(:info, "You are now signed up")
                |> redirect(to: "/member")
            {:error, _changeset} ->
                conn
                |> put_flash(:info, "Something went wrong. Please try again")
                |> redirect(to: conn.request_path)
        end
    end

    @spec get_login(Plug.Conn.t(), any) :: Plug.Conn.t()
    def get_login(conn, _params) do
        conn |> render("login.html", token: get_csrf_token())
    end

    @spec post_login(Plug.Conn.t(), map) :: Plug.Conn.t()
    def post_login(conn, %{"email" => email, "password" => password}) do
        user = User.get_by_email(email)
        if user == nil do
            conn
            |> put_flash(:error, "Invalid credentials. Please try again")
            |> redirect(to: "/member/login")
        end
        case User.is_password_valid?(user, password) do
            true ->
                conn
                |> put_session(:auth_user_id, user.id)
                |> put_flash(:info, "You are logged in")
                |> redirect(to: "/member")
            false ->
                conn
                |> put_flash(:error, "Invalid credentials. Please try again")
                |> redirect(to: "/member/login")
        end
    end

    @spec logout(Plug.Conn.t(), any) :: Plug.Conn.t()
    def logout(conn, _params) do
        conn
        |> clear_session()
        |> put_flash(:info, "You are logged out")
        |> redirect(to: "/")
    end

    @spec get_course(Plug.Conn.t(), map) :: Plug.Conn.t()
    def get_course(conn, %{"course" => course_slug}) do
        course = Course.get_by_slug(course_slug)
        lesson = Lesson.get_by_course_id(course.id) |> List.first
        conn |> redirect(to: "/member/" <> course.slug <> "/" <> lesson.slug)
    end

    @spec get_lesson(Plug.Conn.t(), map) :: Plug.Conn.t()
    def get_lesson(conn, %{"course" => course_slug, "lesson" => lesson_slug}) do
        course = Course.get_by_slug(course_slug)
        lesson = Lesson.get_by_slug_and_course_id(lesson_slug, course.id)
        lessons = Lesson.get_by_course_id(course.id)

        conn |> render("lesson.html",
            [
                course: course,
                lesson: lesson,
                lessons: lessons
            ]
        )
    end
end
