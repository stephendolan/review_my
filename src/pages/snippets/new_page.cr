class Snippets::NewPage < Private::WrappedLayout
  needs save_snippet : SaveSnippet

  def page_title
    "New Snippet"
  end

  def content
    section class: "mx-2 md:mx-10" do
      h1 "Create a New Snippet", class: "text-xl font-semibold text-center my-4"

      render_form(@save_snippet)
    end
  end

  private def render_form(op)
    form_for Snippets::Create, class: "flex-1 flex flex-col space-y-4" do
      m Shared::Field, op.title, &.text_input(autofocus: true, placeholder: "A short and sweet summary of your snippet")

      render_domain_restriction_checkbox(op)

      render_content_editor(op)

      submit "Create", class: "bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end

  private def render_content_editor(op)
    div do
      div class: "hidden" do
        m Shared::Field, op.content, &.textarea
      end

      m Shared::FieldLabel, op.content
      m Shared::FieldErrors, op.content
      div class: "flex-grow flex flex-col" do
        tag("trix-editor", input: "snippet_content", class: "flex-grow trix-content", placeholder: "Your snippet content")
      end
    end
  end

  private def render_domain_restriction_checkbox(op)
    div class: "relative flex items-start" do
      div class: "flex items-center h-5" do
        checkbox(op.domain_restricted, class: "form-checkbox h-4 w-4 text-indigo-600 transition duration-150 ease-in-out")
      end

      div class: "ml-3 text-sm leading-5" do
        m Shared::FieldLabel, op.domain_restricted, "Private"
        para "Restrict revision submissions to users with your domain (#{current_user.email_domain})", class: "text-gray-500"
      end
    end
  end
end
