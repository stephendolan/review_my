class Snippet::CardHeader < BaseComponent
  needs snippet : Snippet

  def render
    div class: "px-4 py-5 border-b border-gray-200 sm:px-6" do
      div class: "-ml-4 -mt-4 flex items-center justify-between flex-wrap sm:flex-no-wrap" do
        div class: "ml-4 mt-4" do
          h3 class: "text-lg flex items-center leading-6 font-medium text-gray-900" do
            span class: "mr-1" do
              mount Snippet::PublicPrivateIcon, snippet: snippet
            end

            text snippet.title
          end

          para class: "mt-1 flex items-center text-sm leading-5 text-gray-500" do
            span "by"
            span snippet.creator.email, class: "ml-1 font-medium"
          end
        end

        div class: "ml-4 mt-4 flex-shrink-0" do
          span class: "relative inline-flex rounded-md shadow-sm", data_controller: "clipboard" do
            url = Snippets::Revisions::New.with(snippet.slug).url

            input class: "sr-only whitespace-pre-wrap", value: url, readonly: true, data_clipboard_target: "source"
            button data_action: "click->clipboard#copy", class: "relative inline-flex items-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:shadow-outline-indigo focus:border-indigo-700 active:bg-indigo-700" do
              i class: "fas fa-clipboard mr-2"

              span "Copy share link", data_clipboard_target: "replace"
            end
          end
        end
      end
    end
  end
end
