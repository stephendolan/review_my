class Shared::Navbar < BaseComponent
  needs current_user : User

  def render
    nav class: "flex-shrink-0 bg-gray-800", data_controller: "toggle" do
      div class: "max-w-7xl mx-auto sm:px-6 lg:px-8" do
        div class: "border-b border-gray-700" do
          div class: "flex items-center justify-between h-16 px-4 sm:px-0" do
            div class: "flex items-center" do
              render_logo

              div class: "hidden md:block" do
                render_desktop_links
              end
            end

            div class: "hidden md:block" do
              render_desktop_account_links
            end

            div class: "-mr-2 flex md:hidden" do
              render_hamburger_menu
            end
          end
        end
      end

      div class: "hidden border-b border-gray-700 md:hidden", data_target: "toggle.toggleable" do
        render_mobile_links
      end
    end
  end

  private def render_desktop_account_links
    div class: "ml-4 flex items-center md:ml-6", data_controller: "toggle" do
      div class: "relative" do
        div do
          button data_action: "click->toggle#toggle", aria_haspopup: "true", aria_label: "User menu", class: "max-w-xs flex items-center text-sm rounded-full text-white focus:outline-none focus:shadow-solid", id: "user-menu" do
            img src: current_user.gravatar_url(size: 64), class: "w-8 h-8 rounded-full"
          end
        end

        div data_target: "toggle.toggleable", class: "hidden origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg" do
          div class: "py-1 rounded-md bg-white shadow-xs" do
            link "Your Profile", to: Me::Show, class: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
            link "Sign out", to: SignIns::Delete, class: "block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
          end
        end
      end
    end
  end

  private def render_hamburger_menu
    button data_action: "click->toggle#toggle", class: "inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:bg-gray-700 focus:text-white" do
      tag "svg", class: "block h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
        tag "path", d: "M4 6h16M4 12h16M4 18h16", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
      end
      tag "svg", class: "hidden h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
        tag "path", d: "M6 18L18 6M6 6l12 12", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
      end
    end
  end

  private def render_mobile_links
    div class: "px-2 py-3 sm:px-3" do
      link "My Dashboard",
        to: Dashboard::Index,
        class: "block px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700"
    end

    div class: "pt-4 pb-3 border-t border-gray-700" do
      div class: "flex items-center px-5" do
        div class: "flex-shrink-0" do
          img src: current_user.gravatar_url(size: 64), class: "w-10 h-10 rounded-full"
        end

        div class: "ml-3" do
          div current_user.email, class: "mt-1 text-sm font-medium leading-none text-gray-400"
        end
      end

      div aria_labelledby: "user-menu", aria_orientation: "vertical", class: "mt-3 px-2", role: "menu" do
        link "Your Profile", to: Me::Show, class: "block px-3 py-2 rounded-md text-base font-medium text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", role: "menuitem"
        link "Sign out", to: SignIns::Delete, class: "mt-1 block px-3 py-2 rounded-md text-base font-medium text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", role: "menuitem"
      end
    end
  end

  private def render_desktop_links
    span
  end

  private def render_logo
    link to: Home::Index, class: "flex-shrink-0 flex items-center" do
      m Image::Logo, height: "h-8", hoverable: true, include_text: true
    end
  end
end
