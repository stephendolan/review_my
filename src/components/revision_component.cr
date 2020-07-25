class RevisionComponent < BaseComponent
  needs revision : Revision
  needs render_link : Bool = false

  def render
    div class: "border border-gray-300 w-full rounded-sm shadow-md", data_controller: "diff" do
      div class: "hidden", data_target: "diff.old" do
        raw revision.snippet.content
      end

      div class: "hidden", data_target: "diff.new" do
        raw revision.content
      end

      div class: "bg-indigo-100 p-2 leading-tight overflow-x-hidden" do
        div class: "font-semibold" do
          if render_link?
            render_revision_link
          else
            span revision.author
          end
        end

        small "#{time_ago_in_words(revision.created_at)} ago", class: "text-gray-700"
      end

      div class: "p-4 trix-content", data_target: "diff.display" do
        raw revision.content
      end
    end
  end

  private def render_revision_link
    link revision.author,
      to: Snippets::Revisions::Show.with(revision.snippet.slug, revision.id),
      class: "hover:text-indigo-500"
  end
end
