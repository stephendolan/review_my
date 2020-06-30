class Snippets::ShowPage < PublicLayout
  needs snippet : Snippet

  def content
    h1 snippet.title, class: "text-center font-semibold text-lg"

    div class: "border-2 border-gray-400 w-full p-6 mt-4" do
      raw snippet.content
    end

    link "Submit a Revision",
      to: Snippets::Revisions::New.with(snippet_id: snippet.slug),
      class: "text-center bg-indigo-500 hover:bg-indigo-700 text-white font-bold mt-4 py-2 px-4 rounded focus:outline-none focus:shadow-outline"
  end
end
