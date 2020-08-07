class Snippets::ShowPage < Private::WrappedLayout
  needs snippet : Snippet

  def page_title
    snippet.title
  end

  def content
    section class: "mx-2 md:mx-10 my-2 md:my-10" do
      m SnippetComponent, snippet: snippet, render_share_link: true

      if snippet.revisions.any?
        h1 "Revisions", class: "text-center font-semibold mt-4"

        render_revisions
      else
        h1 "No revisions yet! Request some using the link above!", class: "text-center font-semibold mt-12"
      end

      if not_snippet_creator? && no_existing_revision?
        link "Submit a Revision",
          to: Snippets::Revisions::New.with(snippet_id: snippet.slug),
          class: "text-center bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold mt-4 py-2 px-4 rounded focus:outline-none focus:shadow-outline"
      end
    end
  end

  private def no_existing_revision?
    snippet.revisions.none? { |revision| revision.creator == current_user }
  end

  private def not_snippet_creator?
    snippet.creator != current_user
  end

  private def render_revisions
    div class: "mt-4 space-y-4" do
      snippet.revisions.each do |revision|
        m RevisionComponent, revision: revision, render_link: true
      end
    end
  end
end
