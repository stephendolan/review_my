class SignInUser < Avram::Operation
  param_key :user
  # You can modify this in src/operations/mixins/user_from_email.cr
  include UserFromEmail

  attribute email : String
  attribute password : String

  # Run validations and yields the operation and the user if valid
  def submit
    user = user_from_email
    validate_credentials(user)

    if valid?
      yield self, user
    else
      yield self, nil
    end
  end

  # `validate_credentials` determines if a user can sign in.
  #
  # If desired, you can add additional checks in this method, e.g.
  #
  #    if user.locked?
  #      email.add_error "is locked out"
  #    end
  private def validate_credentials(user)
    if user
      unless Authentic.correct_password?(user, password.value.to_s)
        password.add_error "is incorrect"
      end
    else
      # Obfuscate whether or not the user is in the database
      email.add_error "is incorrect"
      password.add_error "is incorrect"
    end
  end
end
