class Revision::DiffViewer < BaseComponent
  needs revision : Revision
  needs snippet : Snippet = revision.snippet

  def render
    div class: "border-t border-gray-200 bg-gray-50 px-4 py-4 sm:px-6", data_controller: "diff" do
      link to: Snippets::Revisions::Show.with(snippet.slug, revision), class: "text-sm hover:text-gray-600" do
        span "Revision by"
        span revision.author, class: "ml-1 font-medium"
      end

      div class: "hidden", data_target: "diff.old" do
        raw snippet.content
      end

      div class: "hidden", data_target: "diff.new" do
        raw revision.content
      end

      div class: "mt-2 p-4 bg-white rounded-md shadow trix-content", data_target: "diff.display" do
        raw revision.content
      end
    end
  end
end
