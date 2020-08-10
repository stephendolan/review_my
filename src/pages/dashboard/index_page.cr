class Dashboard::IndexPage < Private::SimpleLayout
  needs snippets : SnippetQuery
  needs snippet_count : Int64
  needs activities : Array(Revision)

  def page_title
    "Dashboard"
  end

  def content
    div class: "flex-grow w-full max-w-7xl mx-auto xl:px-8 lg:flex" do
      div class: "flex-1 min-w-0 bg-white xl:flex" do
        div class: "xl:flex-shrink-0 xl:w-64 xl:border-r xl:border-gray-200 bg-white" do
          render_left_panel
        end

        div class: "bg-white lg:min-w-0 lg:flex-1" do
          render_center_panel
        end
      end

      div class: "bg-gray-50 pr-4 sm:pr-6 lg:pr-8 lg:flex-shrink-0 lg:border-l lg:border-gray-200 xl:pr-0" do
        render_right_panel
      end
    end
  end

  private def render_right_panel
    div class: "pl-6 lg:w-80" do
      div class: "pt-6 pb-2" do
        h2 "Recent Activity", class: "text-sm leading-5 font-semibold"
      end
      div do
        ul class: "divide-y divide-gray-200" do
          if activities.empty?
            li class: "py-4" do
              para "You don't have any recent activity", class: "text-sm leading-5 text-gray-500"
            end
          end

          activities.each do |activity|
            render_activity(activity)
          end
        end
      end
    end
  end

  private def render_activity(activity)
    li class: "py-4" do
      div class: "flex space-x-3" do
        if (user = activity.creator)
          img src: user.gravatar_url(size: 64), class: "w-6 h-6 rounded-full"
        elsif (name = activity.creator_name)
          i class: "fas fa-question-circle"
        end

        div class: "flex-1 space-y-1" do
          div class: "flex items-center justify-between" do
            h3 name, class: "text-sm font-medium leading-5"
            para "#{time_ago_in_words(activity.created_at)} ago", class: "text-sm leading-5 text-gray-500"
          end

          link to: Snippets::Revisions::Show.with(snippet_id: activity.snippet.slug, revision_id: activity) do
            span "Revised '#{activity.snippet.title}'", class: "relative text-sm leading-5 text-gray-500 hover:text-gray-900 font-medium"
          end
        end
      end
    end
  end

  private def render_center_panel
    div class: "pl-4 pr-6 pt-4 pb-4 border-b border-t border-gray-200 sm:pl-6 lg:pl-8 xl:pl-6 xl:pt-6 xl:border-t-0" do
      div class: "flex items-center" do
        h1 "Snippets", class: "flex-1 text-lg leading-7 font-medium"
      end
    end

    ul class: "relative z-0 divide-y divide-gray-200 border-b border-gray-200" do
      snippets.each do |snippet|
        render_snippet(snippet)
      end
    end
  end

  private def render_snippet(snippet)
    li class: "relative pl-4 pr-6 py-5 hover:bg-gray-50 sm:py-6 sm:pl-6 lg:pl-8 xl:pl-6" do
      div class: "flex items-center justify-between space-x-4" do
        div class: "min-w-0 space-y-3" do
          div class: "flex items-center space-x-3" do
            span class: "block truncate" do
              h2 class: "text-sm font-medium leading-5" do
                link to: Snippets::Show.with(snippet_id: snippet.slug) do
                  span class: "absolute inset-0"
                  span class: "mr-1" do
                    m Snippet::PublicPrivateIcon, snippet: snippet
                  end
                  text snippet.title
                end
              end
            end
          end

          span class: "relative inline-flex rounded-md shadow-sm", data_controller: "clipboard" do
            url = Snippets::Revisions::New.with(snippet.slug).url

            input class: "sr-only whitespace-pre-wrap", value: url, readonly: true, data_target: "clipboard.source"
            button data_action: "click->clipboard#copy", class: "inline-flex items-center px-2 py-1 border border-transparent text-xs leading-4 rounded-md text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition ease-in-out duration-150", type: "button" do
              i class: "fas fa-clipboard mr-2"

              span "Copy share link", data_target: "clipboard.replace"
            end
          end
        end

        div class: "sm:hidden" do
          tag "svg", class: "h-5 w-5 text-gray-400", fill: "currentColor", viewBox: "0 0 20 20" do
            tag "path", clip_rule: "evenodd", d: "M7.293 14.707a1 1 0 010-1.414L10.586 10 7.293 6.707a1 1 0 011.414-1.414l4 4a1 1 0 010 1.414l-4 4a1 1 0 01-1.414 0z", fill_rule: "evenodd"
          end
        end

        div class: "hidden sm:flex flex-col flex-shrink-0 items-end space-y-3" do
          para class: "flex items-center space-x-2" do
            link "View #{pluralize(snippet.revisions.size, "Revisions")}",
              to: Snippets::Show.with(snippet.slug),
              class: "relative text-sm leading-5 text-gray-500 hover:text-gray-900 font-medium"
          end

          para class: "flex text-gray-500 text-sm leading-5 space-x-2" do
            span pluralize(snippet.content.split(" ").size, "word")
            span "·"
            span "Created #{time_ago_in_words(snippet.created_at)} ago"
          end
        end
      end
    end
  end

  private def render_left_panel
    div class: "pl-4 pr-6 py-6 sm:pl-6 lg:pl-8 xl:pl-0" do
      div class: "flex items-center justify-between" do
        div class: "flex-1 space-y-8" do
          div class: "space-y-8 sm:space-y-0 sm:flex sm:justify-between sm:items-center xl:block xl:space-y-8" do
            div class: "flex items-center space-x-3" do
              render_user
            end

            div class: "flex flex-col space-y-3 sm:space-y-0 sm:space-x-3 sm:flex-row xl:flex-col xl:space-x-0 xl:space-y-3" do
              span class: "inline-flex rounded-md shadow-sm" do
                render_new_snippet_button
              end
            end
          end
          div class: "flex flex-col space-y-6 sm:flex-row sm:space-y-0 sm:space-x-8 xl:flex-col xl:space-x-0 xl:space-y-6" do
            render_plan

            render_snippet_count
          end
        end
      end
    end
  end

  private def render_plan
    div class: "flex items-center space-x-2" do
      i class: "fas fa-certificate text-gray-400"

      span "Free Plan", class: "text-sm text-gray-500 leading-5 font-medium"
    end
  end

  private def render_snippet_count
    div class: "flex items-center space-x-2" do
      i class: "fas fa-layer-group text-gray-400"

      span pluralize(snippet_count, "Snippet"), class: "text-sm text-gray-500 leading-5 font-medium"
    end
  end

  private def render_user
    div class: "flex-shrink-0 h-10 w-10" do
      img src: current_user.gravatar_url(size: 128), class: "w-10 h-10 rounded-full"
    end

    div class: "space-y-1" do
      div class: "group flex items-center space-x-2.5" do
        div current_user.email, class: "overflow-hidden text-xs leading-5 text-gray-500 font-medium"
      end
    end
  end

  private def render_new_snippet_button
    link "New Snippet", to: Snippets::New, class: "w-full inline-flex items-center justify-center px-4 py-2 border border-transparent text-sm leading-5 font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-500 focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition ease-in-out duration-150"
  end
end
