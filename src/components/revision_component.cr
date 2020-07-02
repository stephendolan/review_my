class RevisionComponent < BaseComponent
  needs revision : Revision
  needs render_link : Bool = false

  def render
    div class: "border-2 border-gray-200 w-full" do
      div class: "p-2 font-semibold bg-indigo-100 flex justify-between" do
        if (creator = revision.creator)
          span creator.email
        else
          span revision.creator_name || "Anonymous"
        end

        if render_link?
          link to: Snippets::Revisions::Show.with(revision.snippet.slug, revision.id) do
            i class: "fas fa-external-link-alt hover:text-indigo-400"
          end
        end
      end

      div class: "p-4" do
        raw revision.content
      end
    end
  end
end
