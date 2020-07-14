class Shared::Navbar < BaseComponent
  needs current_user : User?

  def render
    nav class: "w-full flex items-center justify-between bg-gray-200 border-b px-6 py-4" do
      link to: Home::Index, class: "font-extrabold text-lg #{link_color}" do
        span "ReviewMy"
        span "Email", class: "text-indigo-700"
      end

      if (user = current_user)
        div class: "space-x-4" do
          link to: Me::Show, class: user_button_classes do
            span do
              img src: user.gravatar_url(size: 16), class: "w-4 h-4 mr-2 rounded-full hidden sm:inline"
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

  private def user_button_classes
    "bg-indigo-500 hover:bg-indigo-600 text-gray-100 font-semibold text-sm px-3 py-1 rounded-lg"
  end

  private def link_color
    "hover:text-indigo-800"
  end
end
