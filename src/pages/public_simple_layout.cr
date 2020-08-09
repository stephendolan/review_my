abstract class Public::SimpleLayout
  include Lucky::HTMLPage

  # This layout is meant for public pages, so current_user is optional.
  needs current_user : User?

  abstract def content
  abstract def page_title

  def render
    html_doctype

    html lang: "en" do
      m Shared::LayoutHead, page_title: page_title, context: context

      body do
        div class: "bg-gray-800" do
          if (user = current_user)
            m Shared::Navbar, current_user: user
          else
            m Shared::GuestNavbar
          end
        end

        main class: "bg-gray-50" do
          m Shared::FlashMessages, context.flash

          div class: "mx-auto pt-6" do
            content
          end
        end
      end
    end
  end
end
