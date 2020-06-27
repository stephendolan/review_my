class Shared::AuthNavbar < BaseComponent
  def render
    nav class: "w-full flex items-center justify-between bg-gray-200 border-b px-6 py-4" do
      link "ReviewMy", to: Home::Index, class: "font-extrabold text-lg #{link_color}"

      link "Sign Up", to: SignUps::New, class: "font-semibold #{link_color}"
    end
  end

  private def link_color
    "hover:text-teal-800"
  end
end
