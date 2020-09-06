class Shared::GuestNavbar < BaseComponent
  def render
    nav class: "flex-shrink-0 bg-gray-800", data_controller: "toggle" do
      div class: "max-w-7xl mx-auto sm:px-6 lg:px-8" do
        div class: "border-b border-gray-700" do
          div class: "flex items-center justify-between h-16 px-4 sm:px-0" do
            div class: "flex items-center" do
              render_logo
            end

            div class: "hidden md:block" do
              render_desktop_links
            end

            div class: "-mr-2 flex md:hidden" do
              render_hamburger_menu
            end
          end
        end
      end

      div class: "hidden border-b border-gray-700 md:hidden", data_target: "toggle.toggleable" do
        render_mobile_menu
      end
    end
  end

  private def render_logo
    link to: Home::Index, class: "flex-shrink-0 flex items-center" do
      mount Image::Logo, height: "h-8", append_class: "hover:text-indigo-500", include_text: true
    end
  end

  private def render_hamburger_menu
    button class: "inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:bg-gray-700 focus:text-white", data_action: "click->toggle#toggle" do
      tag "svg", class: "block h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
        tag "path", d: "M4 6h16M4 12h16M4 18h16", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
      end
      tag "svg", class: "hidden h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
        tag "path", d: "M6 18L18 6M6 6l12 12", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
      end
    end
  end

  private def render_desktop_links
    div class: "ml-10 flex items-baseline" do
      link "Sign in",
        to: SignIns::New,
        class: "ml-4 px-3 py-2 rounded-md text-sm font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700"

      link "Sign up",
        to: SignUps::New,
        class: "ml-4 px-3 py-2 rounded-md text-sm font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700"
    end
  end

  private def render_mobile_menu
    div class: "px-2 py-3 sm:px-3" do
      link "Sign in", to: SignIns::New, class: "block px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700"
      link "Sign up", to: SignUps::New, class: "mt-1 block px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700"
    end
  end
end
