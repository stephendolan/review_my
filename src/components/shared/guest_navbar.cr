class Shared::GuestNavbar < BaseComponent
  def render
    nav class: "bg-gray-800" do
      div class: "max-w-7xl mx-auto sm:px-6 lg:px-8" do
        div class: "border-b border-gray-700" do
          div class: "flex items-center justify-between h-16 px-4 sm:px-0" do
            div class: "flex items-center" do
              render_logo
            end

            div class: "hidden md:block" do
              div class: "ml-10 flex items-baseline" do
                link "My Dashboard",
                  to: Dashboard::Index,
                  class: "ml-4 px-3 py-2 rounded-md text-sm font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700"
              end
            end

            div class: "-mr-2 flex md:hidden" do
              button class: "inline-flex items-center justify-center p-2 rounded-md text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:bg-gray-700 focus:text-white" do
                tag "svg", class: "block h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
                  tag "path", d: "M4 6h16M4 12h16M4 18h16", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
                tag "svg", class: "hidden h-6 w-6", fill: "none", stroke: "currentColor", viewBox: "0 0 24 24" do
                  tag "path", d: "M6 18L18 6M6 6l12 12", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2"
                end
              end
            end
          end
        end
      end

      div class: "hidden border-b border-gray-700 md:hidden" do
        div class: "px-2 py-3 sm:px-3" do
          a "Dashboard", class: "block px-3 py-2 rounded-md text-base font-medium text-white bg-gray-900 focus:outline-none focus:text-white focus:bg-gray-700", href: "#"
          a "Team", class: "mt-1 block px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", href: "#"
          a "Projects", class: "mt-1 block px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", href: "#"
          a "Calendar", class: "mt-1 block px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", href: "#"
          a "Reports", class: "mt-1 block px-3 py-2 rounded-md text-base font-medium text-gray-300 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", href: "#"
        end

        div class: "pt-4 pb-3 border-t border-gray-700" do
          div class: "flex items-center px-5" do
            div class: "flex-shrink-0" do
              # img src: user.gravatar_url(size: 16), class: "w-10 h-10 rounded-full"
            end

            div class: "ml-3" do
              div "Tom Cook", class: "text-base font-medium leading-none text-white"
              div "tom@example.com", class: "mt-1 text-sm font-medium leading-none text-gray-400"
            end
          end

          div aria_labelledby: "user-menu", aria_orientation: "vertical", class: "mt-3 px-2", role: "menu" do
            a "Your Profile", class: "block px-3 py-2 rounded-md text-base font-medium text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", href: "#", role: "menuitem"
            a "Settings", class: "mt-1 block px-3 py-2 rounded-md text-base font-medium text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", href: "#", role: "menuitem"
            a "Sign out", class: "mt-1 block px-3 py-2 rounded-md text-base font-medium text-gray-400 hover:text-white hover:bg-gray-700 focus:outline-none focus:text-white focus:bg-gray-700", href: "#", role: "menuitem"
          end
        end
      end
    end
  end

  private def old_navbar
    nav class: "w-full flex items-center justify-between bg-gray-200 border-b px-6 py-4 select-none" do
      if (user = current_user)
        div class: "space-x-4" do
          link to: Me::Show, class: user_button_classes do
            span do
            end
            span user.email, class: "hidden sm:inline"
            span "Account", class: "inline sm:hidden"
          end

          link "Sign Out", to: SignIns::Delete, class: "font-semibold #{link_color}", flow_id: "sign-out-button"
        end
      else
        div class: "space-x-4" do
          link "Sign Up", to: SignUps::New, class: "font-semibold #{link_color}"
          link "Sign In", to: SignIns::New, class: "font-semibold #{link_color}"
        end
      end
    end
  end

  private def render_logo
    link to: Home::Index, class: "flex-shrink-0 flex items-center" do
      m Images::Logo, height: "h-8", append_class: "hover:text-indigo-500", include_text: true
    end
  end

  private def user_button_classes
    "bg-indigo-500 hover:bg-indigo-600 text-gray-100 font-semibold text-sm px-3 py-1 rounded-lg"
  end

  private def link_color
    "hover:text-indigo-800"
  end
end
