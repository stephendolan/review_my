class SignUpConfirmationRequests::NewPage < AuthLayout
  needs operation : RequestSignUpConfirmation

  def content
    div class: "w-full sm:max-w-xs mx-auto mt-10" do
      render_form(@operation)
    end
  end

  private def render_form(op)
    form_for SignUpConfirmationRequests::Create, class: "bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" do
      h1 "Request a new confirmation email", class: "font-semibold text-lg text-center mt-2 mb-4"

      m Shared::Field, op.email, "Email", &.email_input

      div class: "mt-4" do
        div class: "flex items-center justify-between" do
          submit "Resend Confirmation", class: "bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer"
        end
      end
    end
  end
end
