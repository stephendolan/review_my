class Snippets::Revisions::NewPage < PublicLayout
  needs snippet : Snippet
  needs save_revision : SaveRevision

  def content
    render_back_to_snippet_button

    render_existing_snippet

    render_form(@save_revision)
  end

  private def render_back_to_snippet_button
    div do
      link to: Snippets::Show.with(snippet_id: snippet.slug), class: "bg-indigo-500 hover:bg-indigo-700 rounded-full py-1 px-4 text-white text-semibold" do
        i class: "fas fa-arrow-alt-circle-left mr-2"
        text "Back to Snippet"
      end
    end
  end

  private def render_existing_snippet
    h1 snippet.title, class: "text-center font-semibold text-lg mt-6"

    div class: "border-2 border-gray-400 w-full p-6 mt-4" do
      raw snippet.content
    end
  end

  private def render_form(op)
    h1 "Your Revision", class: "text-center font-semibold text-lg mt-4"

    form_for Snippets::Revisions::Create.with(snippet.slug), class: "flex-1 flex flex-col" do
      unless current_user
        m Shared::Field, op.creator_name, &.text_input
      end

      op.content.value = snippet.content
      div class: "flex-grow flex flex-col mt-4" do
        m Shared::Field, op.content, &.textarea(append_class: "hidden")
        tag "trix-editor", input: "revision_content", class: "flex-grow"
      end

      submit "Submit", class: "bg-indigo-500 hover:bg-indigo-700 text-white font-bold mt-4 py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
    end
  end
end
