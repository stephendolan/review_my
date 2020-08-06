class Dashboard::IndexPage < Private::WrappedLayout
  needs snippets : SnippetQuery
  needs activity : Array(Revision)

  def page_title
    "Dashboard"
  end

  def page_header
    "My Dashboard"
  end

  def content
    div class: "flex flex-1" do
      div class: "hidden md:block border-r border-gray shadow-lg px-4 space-y-2 py-4 max-w-xs select-none" do
        render_recent_activity_sidebar
      end

      div class: "flex-1 flex flex-col mx-2 md:mx-10" do
        render_snippet_list
      end
    end
  end

  private def render_recent_activity_sidebar
    h1 "Recent", class: "text-xl font-bold text-center mb-4"

    if activity.empty?
      render_empty_activity
    else
      activity.each do |revision|
        render_recent_revision(revision)
      end
    end
  end

  private def render_recent_revision(revision)
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

  private def render_empty_activity
    div class: "rounded shadow-md bg-indigo-200 px-6 py-4 overflow-x-hidden" do
      div class: "font-semibold text-sm leading-none text-center" do
        para "No recent activity"
      end

      div class: "text-xs text-center" do
        para "Share a snippet or make a revision!"
      end
    end
  end

  private def render_snippet_list
    if snippets.empty?
      render_empty_snippets
    else
      h1 "Your Snippets", class: "text-center my-4 text-xl font-bold"

      render_snippets
    end
  end

  private def render_empty_snippets
    div class: "flex-1 flex flex-col items-center justify-center space-y-8" do
      i class: "far fa-paper-plane fa-9x text-indigo-700"
      h1 "Create a snippet to get started!", class: "text-xl font-extrabold select-none"
      div class: "w-full md:w-3/4 lg:w-2/3 xl:w-1/3" do
        add_snippet_card(text_size: "text-xl")
      end
    end
  end

  private def render_snippets
    div class: "grid md:grid-cols-1 lg:grid-cols-2 xl:grid-cols-3 gap-5" do
      add_snippet_card

      snippets.each do |snippet|
        m SnippetCardComponent, snippet: snippet
      end
    end
  end

  private def add_snippet_card(text_size = "")
    flex = "flex items-center justify-center"

    link to: Snippets::New, class: "h-32 border rounded bg-indigo-500 hover:bg-indigo-600 text-gray-100 #{flex} space-x-2 select-none #{text_size}" do
      i class: "fas fa-plus-circle"
      span "Create a new snippet", class: "font-extrabold"
    end
  end
end
