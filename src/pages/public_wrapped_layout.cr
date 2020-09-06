abstract class Public::WrappedLayout
  include Lucky::HTMLPage

  needs current_user : User?

  abstract def content
  abstract def page_title

  def render
    html_doctype

    html lang: "en" do
      mount Shared::LayoutHead, page_title: page_title, context: context

      body class: "flex flex-col" do
        div class: "bg-gray-800 pb-32" do
          if (user = current_user)
            mount Shared::Navbar, current_user: user
          else
            mount Shared::GuestNavbar
          end

          mount Shared::PageHeader, title: page_title
        end

        main class: "-mt-32" do
          mount Shared::FlashMessages, context.flash
          div class: "max-w-7xl mx-auto pb-12 px-4 sm:px-6 lg:px-8" do
            content
          end
        end
      end
    end
  end
end
