class Snippets::IndexPage < MainLayout
  needs snippets : SnippetQuery

  def page_title
    "Snippets"
  end

  def content
    h1 "Your Snippets", class: "text-center mt-4 mb-10 text-xl font-bold"

    div class: "grid md:grid-cols-2 lg:grid-cols-3 gap-5" do
      add_snippet_card

      snippets.each do |snippet|
        m SnippetCardComponent, snippet: snippet
      end
    end
  end

  private def add_snippet_card
    flex = "flex items-center justify-center"

    link to: Snippets::New, class: "h-32 border rounded bg-indigo-500 hover:bg-indigo-600 text-gray-100 #{flex} space-x-2" do
      i class: "fas fa-plus-circle"
      span "Create a new snippet", class: "font-extrabold"
    end
  end
end
