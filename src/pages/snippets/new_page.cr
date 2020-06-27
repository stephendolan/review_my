class Snippets::NewPage < MainLayout
  needs save_snippet : SaveSnippet

  def content
    render_form(@save_snippet)
  end

  private def render_form(op)
    form_for Snippets::Create do
      m Shared::Field, op.title, "Title", &.text_input
      m Shared::Field, op.content, "Content", &.textarea

      submit "Create", class: "bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end
end
