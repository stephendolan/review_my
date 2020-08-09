class SignIns::Delete < BrowserAction
  delete "/sign_out" do
    sign_out
    redirect to: Home::Index
  end
end
