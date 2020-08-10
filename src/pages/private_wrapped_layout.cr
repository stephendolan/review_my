abstract class Private::WrappedLayout
  include Lucky::HTMLPage

  needs current_user : User

  abstract def content
  abstract def page_title

  def render
    html_doctype

    html lang: "en" do
      m Shared::LayoutHead, page_title: page_title, context: context

      body class: "flex flex-col" do
        div class: "bg-gray-800 pb-32" do
          m Shared::Navbar, current_user: current_user
          m Shared::PageHeader, title: page_title
        end

        main class: "-mt-32" do
          m Shared::FlashMessages, context.flash
          div class: "max-w-7xl mx-auto pb-12 px-4 sm:px-6 lg:px-8" do
            div class: "bg-white rounded-lg shadow" do
              content
            end
          end
        end
      end
    end
  end
end
