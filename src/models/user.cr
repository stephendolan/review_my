class User < BaseModel
  include Carbon::Emailable
  include Authentic::PasswordAuthenticatable

  table do
    column email : String
    column encrypted_password : String
    has_many snippets : Snippet
    has_many revisions : Revision
  end

  def email_domain
    email.split("@").last
  end

  def emailable : Carbon::Address
    Carbon::Address.new(email)
  end
end
