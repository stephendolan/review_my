abstract class AuthLayout
  include Lucky::HTMLPage

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
        m Shared::AuthNavbar
        m Shared::FlashMessages, context.flash

        section class: "flex-grow" do
          content
        end

        m Shared::Footer
      end
    end
  end
end
