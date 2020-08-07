class Snippets::Revisions::NewPage < Public::WrappedLayout
  needs snippet : Snippet
  needs save_revision : SaveRevision

  def page_title
    "Submit a Revision"
  end

  def content
    section class: "mx-2 md:mx-10 my-2 md:my-10", data_controller: "diff" do
      m SnippetComponent, snippet: snippet

      div class: "hidden", data_target: "diff.old" do
        raw snippet.content
      end

      render_form(@save_revision)
    end
  end

  private def render_form(op)
    h1 "Your Revision", class: "text-center font-semibold text-lg my-6"

    form_for Snippets::Revisions::Create.with(snippet.slug), class: "space-y-6" do
      unless current_user
        m Shared::Field, op.creator_name, "Your name", &.text_input(autofocus: true, placeholder: "Sign up to avoid entering this every time!")
      end

      div do
        op.content.value = snippet.content
        div class: "hidden" do
          m Shared::Field, op.content, &.textarea
        end
        m Shared::FieldLabel, op.content, "Revised content"
        m Shared::FieldErrors, op.content

        tag "trix-editor", input: "revision_content", class: "trix-content", autofocus: true, data_target: "diff.new"
      end

      submit "Submit", class: "bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold mt-4 py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end
end
