class SignUpConfirmationEmail < BaseEmail
  def initialize(@user : User)
  end

  to @user
  subject "Confirm your email to get started on ReviewMy"
  templates html, text
end
