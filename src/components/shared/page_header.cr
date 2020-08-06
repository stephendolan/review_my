class Shared::PageHeader < BaseComponent
  needs title : String

  def render
    header class: "py-10" do
      div class: "max-w-7xl mx-auto px-4 sm:px-6 lg:px-8" do
        h1 class: "text-3xl leading-9 font-bold text-white" do
          text title
        end
      end
    end
  end
end
