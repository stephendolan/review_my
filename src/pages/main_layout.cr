abstract class MainLayout
  include Lucky::HTMLPage

  # 'needs current_user : User' makes it so that the current_user
  # is always required for pages using MainLayout
  needs current_user : User

  abstract def content
  abstract def page_title

  def page_title
    ""
  end

  def render
    html_doctype

    html lang: "en" do
      m Shared::LayoutHead, page_title: page_title, context: context

      body class: "flex flex-col min-h-screen" do
        m Shared::Navbar, current_user: current_user
        m Shared::FlashMessages, context.flash

        section class: "flex-grow mx-10 my-6" do
          content
        end

        m Shared::Footer
      end
    end
  end
end
