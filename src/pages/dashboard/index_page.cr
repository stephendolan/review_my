class Dashboard::IndexPage < MainLayout
  needs snippets : SnippetQuery
  needs activity : Array(Revision)

  def page_title
    "Dashboard"
  end

  def content
    div class: "flex flex-1" do
      div class: "hidden md:block border-r border-gray shadow-lg px-4 lg:px-8 space-y-2 py-4 max-w-xs" do
        render_recent_activity_sidebar
      end

      div class: "flex-1 mx-2 md:mx-10" do
        render_snippets
      end
    end
  end

  private def render_recent_activity_sidebar
    h1 "Recent", class: "text-xl font-semibold text-center mb-4"

    activity.each do |revision|
      div class: "rounded shadow-md bg-indigo-200 hover:bg-indigo-300 px-6 py-4 overflow-x-hidden" do
        link Snippets::Revisions::Show.with(revision.snippet.slug, revision.id) do
          div class: "font-semibold text-sm leading-none" do
            if revision.creator == current_user
              text "You "
            else
              text revision.author
            end

            text " revised '#{truncate_text(revision.snippet.title, 30)}'"
          end

          div class: "flex items-center" do
            i class: "far fa-clock mr-1 text-sm"
            small "#{time_ago_in_words(revision.created_at)} ago"
          end
        end
      end
    end
  end

  private def render_snippets
    h1 "Your Snippets", class: "text-center my-4 text-xl font-bold"

    div class: "grid md:grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-5" do
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
