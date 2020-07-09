class SnippetComponent < BaseComponent
  needs snippet : Snippet
  needs render_share_link : Bool = false

  def render
    div class: "border-gray-300 border rounded-sm shadow-md" do
      div class: "bg-indigo-100 p-2 leading-tight" do
        h1 snippet.title, class: "font-semibold text-lg"
        small "by #{snippet.creator.email}", class: "text-gray-700"
      end

      div class: "w-full p-6" do
        raw snippet.content
      end

      if render_share_link?
        render_share_link
      end
    end
  end

  private def render_share_link
    url = Snippets::Revisions::New.with(snippet.slug).url

    div class: "text-center bg-indigo-100 flex justify-between items-center", data_controller: "clipboard" do
      input class: "py-1 bg-transparent focus:outline-none flex-1 text-xs pl-4", value: url, readonly: true, data_target: "clipboard.source"
      button class: "text-xs px-4 bg-indigo-500 hover:bg-indigo-600 text-gray-100 rounded-sm font-semibold flex items-center space-x-2 py-1", data_action: "click->clipboard#copy" do
        i class: "far fa-copy"
        span "Copy & Share"
      end
    end
  end
end
