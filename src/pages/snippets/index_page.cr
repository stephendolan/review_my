class Snippets::IndexPage < MainLayout
  needs snippets : SnippetQuery

  def content
    h1 "Your Snippets", class: "text-center mt-4 mb-10 text-xl font-bold"

    div class: "grid md:grid-cols-3 lg:grid-cols-4 gap-4" do
      card(link: Snippets::New, append_classes: "bg-teal-300 hover:bg-teal-400") do
        div class: "h-full p-4 flex items-center justify-center" do
          i class: "fas fa-plus-circle mr-2 -ml-2"
          span "Create a new snippet", class: "font-extrabold"
        end
      end

      snippets.each do |snippet|
        card(link: Snippets::Show.with(snippet.slug), append_classes: "bg-gray-200 hover:bg-gray-300") do
          div class: "h-full p-4" do
            span snippet.title
            copy_link_button(snippet)
          end
        end
      end
    end
  end

  private def card(link, append_classes)
    link to: link, class: "h-32 border rounded #{append_classes}" do
      yield
    end
  end

  private def copy_link_button(snippet)
    url = Snippets::Show.with(snippet.slug).url

    div data_controller: "clipboard" do
      input value: url, readonly: true, data_target: "clipboard.source", class: "hidden"
      button "Copy", data_action: "click->clipboard#copy"
    end
  end
end
