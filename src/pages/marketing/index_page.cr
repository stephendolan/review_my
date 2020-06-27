class Marketing::IndexPage < AuthLayout
  def content
    div class: "px-3 lg:px-0" do
      div class: "relative bg-white overflow-hidden" do
        div class: "relative pt-6 pb-16 md:pb-20 lg:pb-24 xl:pb-32" do
          div class: "mt-8 mx-auto max-w-screen-xl px-4 sm:mt-12 sm:px-6 md:mt-20 xl:mt-24" do
            div class: "lg:grid lg:grid-cols-12 lg:gap-8" do
              div class: "sm:text-center md:max-w-2xl md:mx-auto lg:col-span-6 lg:text-left" do
                h2 class: "mt-1 text-4xl tracking-tight leading-10 font-bold text-gray-900 sm:leading-none sm:text-6xl lg:text-5xl" do
                  text "Need a quick review?"
                end
                para class: "mt-3 text-base text-gray-500 sm:mt-5 sm:text-xl lg:text-lg xl:text-xl" do
                  text "ReviewMy helps you submit quick snippets for review from others, ensuring that you get the feedback you need quickly, concisely, and intuitively. Use it for emails, text messages, portions of larger documents, or anything else based on text!"
                end
                div class: "mt-5 sm:mt-8 sm:flex sm:justify-center lg:justify-start" do
                  div class: "rounded-md shadow" do
                    link "Get Started", to: SignUps::New, class: "w-full flex items-center justify-center px-8 py-3 border border-transparent text-base leading-6 font-medium rounded-md text-white bg-teal-600 hover:bg-teal-500 hover:text-white focus:outline-none focus:shadow-outline md:py-4 md:text-lg md:px-10"
                  end
                  div class: "ml-3 inline-flex" do
                    link "Sign In", to: SignIns::New, class: "w-full flex items-center justify-center px-8 py-3 border border-transparent text-base leading-6 font-medium rounded-md text-white bg-teal-600 hover:bg-teal-500 hover:text-white focus:outline-none focus:shadow-outline md:py-4 md:text-lg md:px-10"
                  end
                end
              end
              div class: "mt-12 relative sm:max-w-lg sm:mx-auto lg:mt-0 lg:max-w-none lg:mx-0 lg:col-span-6 lg:flex lg:items-center" do
                div class: "relative mx-auto w-full lg:max-w-md" do
                  img src: asset("images/featured.gif"), class: "shadow-lg rounded-lg"
                end
              end
            end
          end
        end
      end

      div class: "bg-gray-200 py-8" do
        div class: "my-8 mx-auto max-w-screen-xl px-4 sm:my-12 sm:px-6 md:my-20 xl:my-24" do
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

  private def icon_step(title, icon)
    li do
      div class: "flex" do
        div class: "flex-shrink-0" do
          div class: "flex items-center justify-center h-12 w-12 rounded-md bg-teal-500 text-white" do
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
