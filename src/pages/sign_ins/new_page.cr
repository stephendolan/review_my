class SignIns::NewPage < AuthLayout
  needs operation : SignInUser

  def content
    div class: "w-full sm:max-w-xs mx-auto mt-10" do
      render_sign_in_form(@operation)
    end
  end

  private def render_sign_in_form(op)
    form_for SignIns::Create, class: "bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" do
      h1 "Sign In", class: "font-semibold text-lg text-center mt-2 mb-4"

      div class: "space-y-4" do
        sign_in_fields(op)
      end

      div class: "mt-4" do
        div class: "flex items-center justify-between" do
          submit "Sign In", class: "bg-teal-500 hover:bg-teal-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer", flow_id: "sign-in-button"

          div do
            div do
              link to: SignUps::New, class: "align-baseline font-bold text-sm text-teal-500 hover:text-teal-800" do
                text "Sign Up"
              end
            end

            div do
              link to: PasswordResetRequests::New, class: "align-baseline font-bold text-sm text-teal-500 hover:text-teal-800" do
                text "Reset Password"
              end
            end
          end
        end
      end
    end
  end

  private def sign_in_fields(op)
    m Shared::Field, op.email, "Email", &.email_input(autofocus: "true")
    m Shared::Field, op.password, "Password", &.password_input
  end
end
