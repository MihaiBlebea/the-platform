alias Platform.{Article, Tag, ArticleTag, User, Role, Course, Lesson}

Article.save(%{
    title: "Build a concurrent, concurrent server that can handle millions of requests with Golang",
    slug: "golang-concurrent-multithreaded-server-with-cache",
    image_url: "https://kazsource.com/wp-content/uploads/2016/10/Wheres-Waldo.jpg",
    description: "As a bonus, we will try to code everything in under 100 lines. This is just because I saw a lot of comments on different forums saying that Go is too verbouse. Let’s put that to the challenge.",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/golang_concurrency_cache_website.md",
    active: false
})

Article.save(%{
    title: "Build a Go Quiz Game with concurrent jobs from scratch in 6 easy steps",
    slug: "go-concurrent-quiz-game",
    image_url: "https://cdn.dribbble.com/users/3421553/screenshots/11589226/dual_zenz2.png",
    description: "As a bonus, we will try to code everything in under 100 lines. This is just because I saw a lot of comments on different forums saying that Go is too verbouse. Let’s put that to the challenge.",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md",
    active: true
})

Article.save(%{
    title: "Github for absolute beginners - How to get started with your first repo?",
    slug: "github-for-beginners-first-repository",
    image_url: "https://portswigger.net/cms/images/54/14/6efb9bc5d143-article-190612-github-body-text.jpg",
    description: "If you just started to code, then git is not for you... That is what they told me. But does it still apply today?",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/go_concurrent_quiz_game.md",
    active: true
})

Article.save(%{
    title: "How to build infrastructure with code, using Terraform with Kubernetes",
    slug: "terraform-with-kubernetes-infrastructure-as-code-part-1",
    image_url: "https://www.terraform.io/assets/images/og-image-large-e60c82fe.png",
    description: "What is this infrastructure as code all about? If you ever had to deal with infrastructure built by somebody else and passed onto you without documentation, then this article is for you.",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/terraform_deploy.md",
    active: true
})

Article.save(%{
    title: "How To Effortlessly Migrate Your Code With This 8 Step Proven Plan",
    slug: "migrate-code-with-8-step-proven-plan",
    image_url: "https://www.scienceabc.com/wp-content/uploads/2015/04/shutterstock_317822987.jpg",
    description: "As time passes, new frameworks appear, older versions are put to rest and the tech environment is shifting and becoming better, faster and more reliable. Application are slowly be becoming legacy. It's time for the dreaded MIGRATION.",
    content_url: "https://raw.githubusercontent.com/MihaiBlebea/mihaiblebea-content/master/migration_plan.md",
    active: true
})

Tag.save(%{
    label: "kube",
    active: true
})

Tag.save(%{
    label: "terraform",
    active: true
})

Tag.save(%{
    label: "golang",
    active: true
})

Tag.save(%{
    label: "leadership",
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

ArticleTag.save(%{
    article_id: 5,
    tag_id: 4
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
