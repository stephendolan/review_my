class SignUps::NewPage < AuthLayout
  needs operation : SignUpUser

  def content
    div class: "w-full sm:max-w-xs mx-auto mt-10" do
      render_sign_up_form(@operation)
    end
  end

  private def render_sign_up_form(op)
    form_for SignUps::Create, class: "bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" do
      h1 "Sign Up", class: "font-semibold text-lg text-center mt-2 mb-4"

      div class: "space-y-4" do
        sign_up_fields(op)
      end

      div class: "mt-4" do
        div class: "flex items-center justify-between" do
          submit "Sign Up", class: "bg-indigo-500 hover:bg-indigo-700 text-gray-100 font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer", flow_id: "sign-up-button"

          link to: SignIns::New, class: "inline-block align-baseline font-bold text-sm text-indigo-500 hover:text-indigo-800" do
            text "Sign in instead"
          end
        end
      end
    end
  end

  private def sign_up_fields(op)
    m Shared::Field, op.email, "Email", &.email_input(autofocus: "true", placeholder: "you@example.com")
    m Shared::Field, op.password, "Password", &.password_input(placeholder: "*" * 12)
    m Shared::Field, op.password_confirmation, "Confirm Password", &.password_input(placeholder: "*" * 12)
  end
end
