class Snippets::Revisions::ShowPage < Private::WrappedLayout
  needs revision : Revision
  needs snippet : Snippet = revision.snippet

  def page_title
    if (creator = revision.creator)
      "Revision by #{creator.email}"
    else
      "Revision by #{revision.creator_name}"
    end
  end

  def content
    div class: "bg-white overflow-hidden shadow rounded-lg" do
      m Snippet::CardHeader, snippet: snippet

      div class: "px-4 py-5 sm:p-6 trix-content" do
        raw snippet.content
      end

      m Revision::DiffViewer, revision: revision
    end
  end
end
