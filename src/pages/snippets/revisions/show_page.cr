class Snippets::Revisions::ShowPage < MainLayout
  needs revision : Revision

  def content
    if revision.snippet.creator_id == current_user.id
      render_back_to_snippet_button
    end

    render_existing_snippet

    h1 class: "text-center font-semibold text-lg mt-6" do
      text "Your " if revision.creator == current_user
      text "Revision"
    end

    div class: "mt-2" do
      m RevisionComponent, revision: revision
    end
  end

  private def render_back_to_snippet_button
    div do
      link to: Snippets::Show.with(snippet_id: revision.snippet.slug), class: "bg-indigo-500 hover:bg-indigo-700 rounded-full py-1 px-4 text-gray-100 text-semibold" do
        i class: "fas fa-arrow-alt-circle-left mr-2"
        text "Back to Snippet"
      end
    end
  end

  private def render_existing_snippet
    unless current_user == revision.snippet.creator
      h1 class: "text-center font-bold text-lg mt-6" do
        text "You're viewing a snippet by "
        text revision.snippet.creator.email
      end
    end

    h1 revision.snippet.title, class: "text-center font-semibold text-lg mt-4"

    render_content(revision.snippet.content)
  end

  private def render_revision
    h1 "Revision", class: "text-center font-semibold text-lg mt-4"

    render_content(revision.content)
  end

  private def render_content(content)
    div class: "border-2 border-gray-400 w-full p-6 mt-4" do
      raw content
    end
  end
end
