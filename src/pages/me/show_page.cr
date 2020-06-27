class Me::ShowPage < MainLayout
  def content
    h1 "Hey, #{current_user.email}!", class: "text-lg text-center"

    para class: "text-center mt-10" do
      text "You can't do too much right now... but more will be coming soon!"
    end
  end
end
