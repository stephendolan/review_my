class PasswordResetRequests::NewPage < AuthLayout
  needs operation : RequestPasswordReset

  def content
    div class: "w-full sm:max-w-xs mx-auto mt-10" do
      render_form(@operation)
    end
  end

  private def render_form(op)
    form_for PasswordResetRequests::Create, class: "bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" do
      h1 "Reset your password", class: "font-semibold text-lg text-center mt-2 mb-4"

      m Shared::Field, op.email, "Email", &.email_input

      div class: "mt-4" do
        div class: "flex items-center justify-between" do
          submit "Reset Password", class: "bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer", flow_id: "request-password-reset-button"
        end
      end
    end
  end
end
