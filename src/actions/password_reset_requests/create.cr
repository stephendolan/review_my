class PasswordResetRequests::Create < BrowserAction
  include Auth::RedirectSignedInUsers

  route do
    RequestPasswordReset.new(params).submit do |operation, user|
      if user
        PasswordResetRequestEmail.new(user).deliver
      end

      flash.keep
      flash.success = "If your email is in our system, you will receive a password reset email shortly"
      redirect to: SignIns::New
    end
  end
end
