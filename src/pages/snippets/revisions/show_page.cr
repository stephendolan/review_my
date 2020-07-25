class Snippets::Revisions::ShowPage < MainLayout
  needs revision : Revision

  def page_title
    if (creator = revision.creator)
      "Revision by #{creator.email}"
    else
      "Revision by #{revision.creator_name}"
    end
  end

  def content
    section class: "mx-2 md:mx-10 my-2 md:my-10" do
      m SnippetComponent, snippet: revision.snippet

      h1 class: "text-center font-semibold text-lg mt-6" do
        text "Your " if revision.creator == current_user
        text "Revision"
      end

      div class: "mt-2" do
        m RevisionComponent, revision: revision
      end
    end
  end
end
