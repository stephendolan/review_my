class Me::ShowPage < Private::WrappedLayout
  def page_title
    current_user.email
  end

  def content
    section class: "mx-2 md:mx-10 my-2 md:my-10" do
      h1 "Hey, #{current_user.email}!", class: "text-lg text-center"

      para class: "text-center mt-10" do
        text "You can't do too much right now... but more will be coming soon!"
      end
    end
  end
end
