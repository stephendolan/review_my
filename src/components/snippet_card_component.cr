class SnippetCardComponent < BaseComponent
  needs snippet : Snippet

  def render
    div class: "h-32 border border-gray-300 rounded-sm flex flex-col justify-between shadow-md" do
      div class: "relative py-1 bg-indigo-100" do
        render_public_private_icon
        render_title
        render_delete_icon
      end

      div class: "text-center select-none" do
        text pluralize(snippet.revisions.size, "revision")
      end

      render_copy_link
    end
  end

  private def render_title
    div class: "mx-10 overflow-x-auto text-center" do
      link snippet.title, to: Snippets::Show.with(snippet.slug), class: "font-semibold hover:text-indigo-600"
    end
  end

  private def render_delete_icon
    link to: Snippets::Delete.with(snippet.slug), data_confirm: "Are you sure? This action is not reversible." do
      i class: "fas fa-trash absolute top-0 right-0 m-2 text-red-500 hover:text-red-600"
    end
  end

  private def render_public_private_icon
    span do
      if snippet.domain_restricted?
        i class: "fas fa-lock absolute top-0 left-0 m-2 text-indigo-600", title: "Locked to domain"
      else
        i class: "fas fa-lock-open absolute top-0 left-0 m-2 text-indigo-600", title: "Public"
      end
    end
  end

  private def render_copy_link
    url = Snippets::Revisions::New.with(snippet.slug).url

    div class: "text-center bg-indigo-100 flex justify-between items-center", data_controller: "clipboard" do
      input class: "py-1 bg-transparent focus:outline-none w-full text-xs pl-4", value: url, readonly: true, data_target: "clipboard.source"
      button class: "text-xs h-full px-4 bg-indigo-500 hover:bg-indigo-600 text-gray-100 font-semibold flex items-center space-x-2", data_action: "click->clipboard#copy" do
        i class: "far fa-copy"
        span "Copy"
      end
    end
  end
end
