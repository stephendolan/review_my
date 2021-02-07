class SignUpConfirmationRequests::New < BrowserAction
  include Auth::RedirectSignedInUsers

  get "/sign_up_confirmations/new" do
    html SignUpConfirmationRequests::NewPage, operation: RequestSignUpConfirmation.new
  end
end
