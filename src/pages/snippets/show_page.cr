class Snippets::ShowPage < MainLayout
  needs snippet : Snippet

  def content
    h1 snippet.title, class: "text-center font-semibold text-lg"

    div class: "border-2 border-gray-400 w-full p-6 mt-4" do
      raw snippet.content
    end

    render_share_link

    if snippet.revisions.any?
      h1 "Revisions", class: "text-center font-semibold mt-4"

      render_revisions
    else
      h1 "No revisions yet! Request some using the link above!", class: "text-center font-semibold mt-12"
    end

    if not_snippet_creator? && no_existing_revision?
      link "Submit a Revision",
        to: Snippets::Revisions::New.with(snippet_id: snippet.slug),
        class: "text-center bg-indigo-500 hover:bg-indigo-700 text-white font-bold mt-4 py-2 px-4 rounded focus:outline-none focus:shadow-outline"
    end
  end

  private def no_existing_revision?
    snippet.revisions.none? { |revision| revision.creator == current_user }
  end

  private def not_snippet_creator?
    snippet.creator != current_user
  end

  private def render_share_link
    url = Snippets::Revisions::New.with(snippet.slug).url

    div class: "text-center bg-indigo-100 border-2 border-t-0 border-gray-400 flex justify-between items-center", data_controller: "clipboard" do
      input class: "py-1 bg-transparent focus:outline-none flex-1 text-xs pl-4", value: url, readonly: true, data_target: "clipboard.source"
      button class: "text-xs px-4 bg-indigo-500 hover:bg-indigo-600 text-white font-semibold flex items-center space-x-2 py-1", data_action: "click->clipboard#copy" do
        i class: "far fa-copy"
        span "Copy & Share"
      end
    end
  end

  private def render_revisions
    div class: "mt-4 space-y-4" do
      snippet.revisions.each do |revision|
        div class: "border-2 border-gray-400 w-full" do
          div class: "p-2 font-semibold bg-gray-400" do
            if (creator = revision.creator)
              text creator.email
            else
              text revision.creator_name || "Anonymous"
            end
          end

          div class: "p-4" do
            raw revision.content
          end
        end
      end
    end
  end
end
