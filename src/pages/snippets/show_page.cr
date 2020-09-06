class Snippets::ShowPage < Private::WrappedLayout
  needs snippet : Snippet

  def page_title
    "Revisions for '#{snippet.title}'"
  end

  def content
    div class: "bg-white overflow-hidden shadow rounded-lg" do
      mount Snippet::CardHeader, snippet: snippet

      div class: "px-4 py-5 sm:p-6 trix-content" do
        raw snippet.content
      end

      snippet.revisions.each do |revision|
        mount Revision::DiffViewer, revision: revision
      end
    end
  end
end
