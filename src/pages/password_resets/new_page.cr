class PasswordResets::NewPage < AuthLayout
  needs operation : ResetPassword
  needs user_id : UUID

  def content
    div class: "w-full sm:max-w-xs mx-auto mt-10" do
      render_password_reset_form(@operation)
    end
  end

  private def render_password_reset_form(op)
    form_for PasswordResets::Create.with(@user_id), class: "bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4" do
      h1 "Reset your password", class: "font-semibold text-lg text-center mt-2 mb-4"

      div class: "space-y-4" do
        m Shared::Field, op.password, "Password", &.password_input(autofocus: "true")
        m Shared::Field, op.password_confirmation, "Confirm Password", &.password_input
      end

      div class: "mt-4" do
        div class: "flex items-center justify-between" do
          submit "Update Password", class: "bg-indigo-500 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline cursor-pointer", flow_id: "update-password-button"
        end
      end
    end
  end
end
