alias Platform.{Article, Tag, ArticleTag, User, Role, Course, Lesson}

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

Article.save(%{
    title: "Github for absolute beginners - How to get started with your first repo?",
    subtitle: "Just a subtitle",
    slug: "github-for-beginners-first-repository",
    image_url: "https://portswigger.net/cms/images/54/14/6efb9bc5d143-article-190612-github-body-text.jpg",
    description: "If you just started to code, then git is not for you... That is what they told me. But does it still apply today?",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md"
})

Article.save(%{
    title: "How to build infrastructure with code, using Terraform with Kubernetes",
    subtitle: "Just a subtitle",
    slug: "terraform-with-kubernetes-infrastructure-as-code-part-1",
    image_url: "https://www.terraform.io/assets/images/og-image-large-e60c82fe.png",
    description: "What is this infrastructure as code all about? If you ever had to deal with infrastructure built by somebody else and passed onto you without documentation, then this article is for you.",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/terraform_deploy.md"
})

Tag.save(%{
    label: "kube",
    active: true
})

Tag.save(%{
    label: "terraform",
    active: true
})

ArticleTag.save(%{
    article_id: 1,
    tag_id: 1
})

ArticleTag.save(%{
    article_id: 2,
    tag_id: 1
})

ArticleTag.save(%{
    article_id: 3,
    tag_id: 2
})

ArticleTag.save(%{
    article_id: 4,
    tag_id: 2
})

Role.save(%{
    title: "Admin",
    label: "admin",
    active: true
})

Role.save(%{
    title: "Member",
    label: "member",
    active: true
})

User.save(%{
    name: "Mihai",
    email: "mihaiserban.blebea@gmail.com",
    password: "intrex",
    role_id: 1,
    marketing_consent: true
})

User.save(%{
    name: "Jack",
    email: "jack@gmail.com",
    password: "intrex",
    role_id: 2,
    marketing_consent: true
})

Course.save(%{
    title: "Build a snake game in Go and Vue",
    slug: "snake-game-go-vue",
    description: "Build this interesting game in Go backend and Vue for front end"
})

Course.save(%{
    title: "Build dependency injection container in Go",
    slug: "dependency-container-in-go",
    description: "Build a simple dependency injection container in Go and learn how to generate code at compile time"
})

Lesson.save(%{
    course_id: 1,
    title: "First lesson",
    slug: "lesson-1",
    video_url: "https://player.vimeo.com/video/507091358",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md"
})

Lesson.save(%{
    course_id: 1,
    title: "Second lesson",
    slug: "lesson-2",
    video_url: "https://player.vimeo.com/video/507091358",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md"
})

Lesson.save(%{
    course_id: 1,
    title: "Third lesson",
    slug: "lesson-3",
    video_url: "https://player.vimeo.com/video/507091358",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md"
})

Lesson.save(%{
    course_id: 2,
    title: "First lesson",
    slug: "lesson-1",
    video_url: "https://player.vimeo.com/video/507091358",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md"
})

Lesson.save(%{
    course_id: 2,
    title: "Second lesson",
    slug: "lesson-2",
    video_url: "https://player.vimeo.com/video/507091358",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md"
})

Lesson.save(%{
    course_id: 2,
    title: "Third lesson",
    slug: "lesson-3",
    video_url: "https://player.vimeo.com/video/507091358",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md"
})
