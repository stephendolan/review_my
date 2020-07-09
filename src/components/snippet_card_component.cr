class SnippetCardComponent < BaseComponent
  needs snippet : Snippet

  def render
    div class: "h-32 border border-gray-300 rounded-sm flex flex-col justify-between shadow-md" do
      div class: "relative py-1 bg-indigo-100" do
        div snippet.title, class: "text-center font-semibold px-10"
        link to: Snippets::Show.with(snippet.slug) do
          i class: "fas fa-external-link-alt absolute top-0 right-0 m-2 hover:text-indigo-400"
        end
      end

      div class: "text-center select-none" do
        text pluralize(snippet.revisions.size, "revision")
      end

      render_copy_link
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
