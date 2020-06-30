class Snippets::Revisions::NewPage < MainLayout
  needs snippet : Snippet

  def content
    div do
      link to: Snippets::Show.with(snippet_id: snippet.slug), class: "bg-indigo-500 hover:bg-indigo-700 rounded-full py-1 px-4 text-white text-semibold" do
        i class: "fas fa-arrow-alt-circle-left mr-2"
        text "Back to Snippet"
      end
    end

    h1 snippet.title, class: "text-center font-semibold text-lg mt-6"

    div class: "border-2 border-gray-400 w-full p-6 mt-4" do
      raw snippet.content
    end

    h1 "Your Revision", class: "text-center font-semibold text-lg mt-4"

    div class: "mt-4 flex-1 flex flex-col" do
      tag "trix-editor"
    end
  end
end
