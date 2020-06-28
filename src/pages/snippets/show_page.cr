class Snippets::ShowPage < MainLayout
  needs snippet : Snippet

  def content
    h1 "Well, we're looking at snippet #{snippet.title}"
  end
end
