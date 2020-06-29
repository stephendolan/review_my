class Snippets::IndexPage < MainLayout
  needs snippets : SnippetQuery

  def content
    div class: "text-center my-6" do
      link "Create a new snippet", to: Snippets::New, class: "p-3 border rounded text-white bg-teal-400 hover:bg-teal-500"
    end

    ul class: "divide-y-2" do
      snippets.each do |snippet|
        li class: "w-full p-6 bg-gray-200 flex items-center justify-between" do
          link snippet.title, to: Snippets::Show.with(snippet.slug), class: "text-teal-800 hover:text-teal-500"
          div data_controller: "rich-text", data_rich_text_initial_content: snippet.content.to_json, data_rich_text_readonly: true do
            div data_target: "rich-text.editor"
          end
        end
      end
    end
  end
end
