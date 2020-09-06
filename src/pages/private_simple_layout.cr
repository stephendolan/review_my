abstract class Private::SimpleLayout
  include Lucky::HTMLPage

  needs current_user : User

  abstract def content
  abstract def page_title

  def render
    html_doctype

    html lang: "en" do
      mount Shared::LayoutHead, page_title: page_title, context: context

      body do
        div class: "invisible lg:visible fixed top-0 left-0 w-1/2 h-full bg-white"
        div class: "invisible lg:visible fixed top-0 right-0 w-1/2 h-full bg-gray-50"

        div class: "relative min-h-screen flex flex-col" do
          div class: "flex-shrink-0 bg-gray-800" do
            mount Shared::Navbar, current_user: current_user
          end

          div class: "flex-1 flex flex-col" do
            content
          end
        end
      end
    end
  end
end
