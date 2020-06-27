class Snippets::IndexPage < MainLayout
  needs snippets : SnippetQuery

  def content
    div class: "text-center my-6" do
      link "Create a new snippet", to: Snippets::New, class: "p-3 border rounded text-white bg-teal-400 hover:bg-teal-500"
    end

    ul do
      snippets.each do |snippet|
        li class: "w-full p-6 bg-gray-200 flex items-center justify-between" do
          span snippet.slug
          span snippet.title
          span snippet.content
        end
      end
    end
  end
end
