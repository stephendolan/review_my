class SignUpConfirmationRequests::New < BrowserAction
  include Auth::RedirectSignedInUsers

  route do
    html SignUpConfirmationRequests::NewPage, operation: RequestSignUpConfirmation.new
  end
end
