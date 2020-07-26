class Shared::Footer < BaseComponent
  def render
    nav class: "w-full flex items-center justify-between bg-gray-100 border-t p-2 select-none" do
      span class: "text-xs font-semibold" do
        text "© #{Time.local.year} "
        a "StephenCodes", href: "https://stephencodes.com", target: "_blank", class: link_color
      end

      span class: "text-xs font-semibold" do
        text "Icons by "
        a "FontAwesome", href: "https://fontawesome.com", target: "_blank", class: link_color
      end
    end
  end

  private def link_color
    "hover:text-gray-800"
  end
end
