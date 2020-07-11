class Snippets::NewPage < MainLayout
  needs save_snippet : SaveSnippet

  def page_title
    "New Snippet"
  end

  def content
    render_form(@save_snippet)
  end

  private def render_form(op)
    form_for Snippets::Create, class: "flex-1 flex flex-col space-y-4" do
      m Shared::Field, op.title, &.text_input(autofocus: true, placeholder: "A short and sweet summary of your snippet")

      label class: "block" do
        checkbox(op.domain_restricted, class: "mr-2 leading-tight")

        span class: "text-sm text-gray-600 select-none" do
          text "Restrict revisions to your domain"
          b " (#{current_user.email_domain})"
        end

        m Shared::FieldErrors, op.domain_restricted
      end

      div class: "flex-grow flex flex-col" do
        m Shared::Field, op.content, &.textarea(append_class: "hidden")
        tag("trix-editor", input: "snippet_content", class: "flex-grow", placeholder: "Your snippet content")
      end

      submit "Create", class: "bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end
end
