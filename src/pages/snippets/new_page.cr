class Snippets::NewPage < MainLayout
  needs save_snippet : SaveSnippet

  def content
    render_form(@save_snippet)
  end

  private def render_form(op)
    form_for Snippets::Create, class: "flex-1 flex flex-col" do
      m Shared::Field, op.title, &.text_input(autofocus: true)

      div class: "flex-grow flex flex-col mt-4" do
        m Shared::Field, op.content, &.textarea(append_class: "hidden")
        tag("trix-editor", input: "snippet_content", class: "flex-grow")
      end

      submit "Create", class: "bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold mt-4 py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end
end
