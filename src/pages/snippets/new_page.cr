class Snippets::NewPage < MainLayout
  needs save_snippet : SaveSnippet

  def content
    render_form(@save_snippet)
  end

  private def render_form(op)
    form_for Snippets::Create do
      m Shared::Field, op.title, "Title", &.text_input

      m Shared::Field, op.content, "Content", &.textarea(append_class: "hidden")
      tag("trix-editor", input: "snippet_content")

      submit "Create", class: "bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end
end
