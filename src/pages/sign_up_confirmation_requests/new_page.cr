class SignUpConfirmationRequests::NewPage < Public::SimpleLayout
  needs operation : RequestSignUpConfirmation

  def page_title
    "Confirmation Email Request"
  end

  def content
    mount Shared::CenteredFormPanel, title: title_text do
      render_form(operation)
    end
  end

  private def render_form(op)
    form_for SignUpConfirmationRequests::Create do
      mount Shared::Field, op.email, "Email", &.email_input(autofocus: "true", placeholder: "you@example.com")

      div class: "mt-6" do
        span class: "block w-full rounded-md shadow-sm" do
          submit "Resend confirmation", class: "w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-500 cursor-pointer focus:outline-none focus:border-indigo-700 focus:shadow-outline-indigo active:bg-indigo-700 transition duration-150 ease-in-out", flow_id: "sign-in-button"
        end
      end
    end
  end

  private def title_text
    "Resend confirmation email"
  end
end
