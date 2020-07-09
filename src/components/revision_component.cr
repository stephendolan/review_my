class RevisionComponent < BaseComponent
  needs revision : Revision
  needs render_link : Bool = false

  def render
    div class: "border border-gray-300 w-full rounded-sm shadow-md" do
      div class: "bg-indigo-100 p-2 leading-tight" do
        div class: "font-semibold flex justify-between" do
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

        small "#{time_ago_in_words(revision.created_at)} ago", class: "text-gray-700"
      end

      div class: "p-4" do
        raw revision.content
      end
    end
  end
end
