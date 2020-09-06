class UserBox < Avram::Box
  def initialize
    email "#{sequence("test-email")}@example.com"
    encrypted_password Authentic.generate_encrypted_password("password")
    confirmation_token "test_token"
    confirmed_at Time.utc
  end
end
