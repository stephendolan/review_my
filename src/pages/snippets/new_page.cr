class Snippets::NewPage < MainLayout
  needs save_snippet : SaveSnippet

  def content
    render_form(@save_snippet)
  end

  private def render_form(op)
    form_for Snippets::Create do
      div class: "space-y-4" do
        m Shared::Field, op.title, "Title", &.text_input

        div data_controller: "rich-text" do
          m Shared::Field, op.content, "Content", &.textarea(append_class: "hidden", data_target: "rich-text.input")
          div class: "h-1/2", data_target: "rich-text.editor"
        end

        submit "Create", class: "bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
      end
    end
  end
end
