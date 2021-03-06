class PasswordResetRequests::Create < BrowserAction
  include Auth::RedirectSignedInUsers

  post "/password_resets" do
    RequestPasswordReset.run(params) do |_operation, user|
      if user
        PasswordResetRequestEmail.new(user).deliver
      end

      flash.success = "If your email is in our system, you will receive a password reset email shortly"
      redirect to: SignIns::New
    end
  end
end
