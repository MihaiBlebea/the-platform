# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Platform.Repo.insert!(%Platform.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Platform.{Article, User}

Article.save(%{
    title: "Build a concurrent, concurrent server that can handle millions of requests with Golang",
    subtitle: "Just a subtitle",
    slug: "golang-concurrent-multithreaded-server-with-cache",
    image_url: "https://thetravelvertical.com/wp-content/uploads/2019/11/dog-3822183_1920-1024x608.jpg",
    description: "This is the second article",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/golang_concurrency_cache_website.md"
})

Article.save(%{
    title: "Build a Go Quiz Game with concurrent jobs from scratch in 6 easy steps",
    subtitle: "Just a subtitle",
    slug: "go-concurrent-quiz-game",
    image_url: "https://www.sbs.com.au/guide/sites/sbs.com.au.guide/files/styles/full/public/8-out-of-10-cats.jpg",
    description: "Coding a game that involves concurrency must be sooooo complicated... right? Not really! It is quite easy by using Go routines system. Let me show you how to do it.",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md"
})

User.save(%{
    name: "Mihai",
    email: "mihaiserban.blebea@gmail.com",
    password: "intrex",
    role_id: 1,
    marketing_consent: true
})
