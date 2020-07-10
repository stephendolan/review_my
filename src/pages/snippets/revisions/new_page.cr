class Snippets::Revisions::NewPage < PublicLayout
  needs snippet : Snippet
  needs save_revision : SaveRevision

  def content
    m SnippetComponent, snippet: snippet

    render_form(@save_revision)
  end

  private def render_form(op)
    h1 "Your Revision", class: "text-center font-semibold text-lg mt-4"

    form_for Snippets::Revisions::Create.with(snippet.slug), class: "flex-1 flex flex-col" do
      unless current_user
        m Shared::Field, op.creator_name, "Your name", &.text_input(autofocus: true, placeholder: "Sign up to avoid entering this every time!")
      end

      op.content.value = snippet.content
      div class: "flex-grow flex flex-col mt-4" do
        m Shared::Field, op.content, "Revised content", &.textarea(append_class: "hidden")
        tag "trix-editor", input: "revision_content", class: "flex-grow", autofocus: true
      end

      submit "Submit", class: "bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold mt-4 py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end
end
