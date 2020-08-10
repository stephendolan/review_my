class Me::ShowPage < Private::WrappedLayout
  def page_title
    "Your account"
  end

  def content
    section class: "px-2 md:px-10 py-2 md:py-10" do
      h1 "Hey, #{current_user.email}!", class: "text-lg text-center"

      para class: "text-center mt-10" do
        text "You can't do too much right now... but more will be coming soon!"
      end
    end
  end
end
