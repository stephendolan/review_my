class Marketing::IndexPage < AuthLayout
  def content
    div class: "select-none bg-white" do
      div class: "px-6 py-6 sm:py-20 lg:py-32 flex flex-col lg:flex-row text-center lg:text-left items-center justify-center lg:space-x-12 space-y-12 lg:space-y-0" do
        div class: "md:max-w-2xl" do
          render_main_title

          render_title_subtext

          div class: "flex sm:flex-row flex-col space-y-4 sm:space-y-0 justify-center lg:justify-start sm:space-x-3 mt-6" do
            render_action_button(title: "Get Started", link: SignUps::New)
            render_action_button(title: "Sign In", link: SignIns::New)
          end
        end

        render_app_preview_gif
      end

      div class: "bg-gray-200 py-8" do
        div class: "my-8 mx-auto max-w-screen-xl px-4 sm:my-12 sm:px-6 lg:my-20 xl:my-24" do
          div class: "text-center" do
            h2 "How does it work?", class: "font-bold text-4xl"
          end
          div class: "mt-8 max-w-2xl mx-auto" do
            ul class: "mt-10 space-y-10 list-none" do
              icon_step(title: "Create", icon: "fas fa-feather-alt") do
                text "It could be an email, text message, or any content that you want someone else to take a look at!"
              end

              icon_step(title: "Share", icon: "fas fa-share") do
                text "Share your text with any number of other folks who can give feedback. Don't worry, none of them will see others' feedback, so you'll get insight into how different people would revise your content."
              end

              icon_step(title: "Adapt", icon: "fas fa-bullseye") do
                text "Review the feedback you've received, incoporate what you want, and ship it!"
              end
            end
          end
        end
      end
    end
  end

  private def render_app_preview_gif
    img src: "https://media.giphy.com/media/KDDb6Kh2zUhhaD4x0P/giphy.gif", class: "shadow-lg rounded-lg"
  end

  private def render_action_button(title, link)
    div class: "flex" do
      link title, to: link, class: "px-8 py-3 border border-transparent rounded-md text-gray-100 bg-indigo-600 hover:bg-indigo-500 hover:text-gray-100 focus:outline-none focus:shadow-outline lg:py-4 lg:text-lg lg:px-10 w-full"
    end
  end

  private def render_main_title
    h2 class: "text-4xl tracking-tight leading-10 font-bold text-gray-900 sm:leading-none sm:text-5xl" do
      text "Need a quick review?"
    end
  end

  private def render_title_subtext
    para class: "mt-3 text-base text-gray-600 sm:mt-5 sm:text-xl lg:text-lg xl:text-xl" do
      text "ReviewMy helps you submit quick snippets for review from others, ensuring that you get the feedback you need quickly, concisely, and intuitively. Use it for emails, text messages, portions of larger documents, or anything else based on text!"
    end
  end

  private def icon_step(title, icon)
    li do
      div class: "flex" do
        div class: "flex-shrink-0" do
          div class: "flex items-center justify-center h-12 w-12 rounded-md bg-indigo-500 text-gray-100" do
            i class: "#{icon} text-lg"
          end
        end
        div class: "ml-4" do
          h5 title, class: "text-lg leading-6 font-medium text-gray-900"
          para class: "mt-2 text-base leading-6 text-gray-500" do
            yield
          end
        end
      end
    end
  end
end
