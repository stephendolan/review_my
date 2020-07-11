class SignUpAlreadyConfirmedEmail < BaseEmail
  def initialize(@user : User)
  end

  to @user
  subject "Your ReviewMy email is already confirmed"
  templates html, text
end
