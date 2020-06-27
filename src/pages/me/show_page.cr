class Me::ShowPage < MainLayout
  def content
    h1 "Hey, #{current_user.email}!", class: "text-lg text-center"

    para class: "text-center mt-10" do
      text "You can't do too much right now... but you can "

      link "request a password reset", to: PasswordResetRequests::New, class: "text-teal-500 hover:text-gray-800"
    end
  end
end
