class SignIns::Create < BrowserAction
  include Auth::RedirectSignedInUsers

  post "/sign_in" do
    flash.keep
    SignInUser.new(params).submit do |operation, authenticated_user|
      if authenticated_user
        sign_in(authenticated_user)
        Authentic.redirect_to_originally_requested_path(self, fallback: Home::Index)
      else
        html NewPage, operation: operation
      end
    end
  end
end
